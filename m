Received: from mta0.migadu.com (out-212.mta0.migadu.com [91.218.175.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446283AD51C
	for <linux-rt-devel@lists.linux.dev>; Mon, 24 Aug 2026 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787564039; cv=none; b=GJRoAhR+OzA5aVQNOTAA0Yoyhgb4W7tML7QGeF28hTHnaMnPbvcXksZMtH1EJHmRWNqboBlDUFL2tLbXg58By93PVNKKVc9qfFdXEDa3jRIZk4+q/57Bs/5+Bkq7EOPbMe+s2V4BD+grYbRVi+4G4khNsqxdPWS964icGZ5GrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787564039; c=relaxed/simple;
	bh=zh+PWWBumyjNQoqNmlFeILUqJEyvBvApeFkA+cmfv5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/iriIsM5Snt8TcFjLyaMMZKwXMQDM0ARHRSQ4XJSesnweYVgMATZ/+DArN3ESQrqY4IEQu+NSsIsTxRwefiHXgGizkULU47DLcbltyHRqv8/apDlQU/9R8v023kHxoiPuyBGcZerL86b5uO8TPXc+rHYamu/HV0Jd7XhrLnBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CW4J0DdB; arc=none smtp.client-ip=91.218.175.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CW4J0DdB"
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=zh+PWWBumyjNQoqNmlFeILUqJEyvBvApeFkA+cmfv5U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787564035; v=1; x=1788168835;
 b=CW4J0DdBavgIgAkeyK43SmFwfM7gFi0GtAtfvVIR+TVHb7vJXOPPmnccmhLeuNYPQGVgTR9A
 jljxv0Qk65IiDJDWTr9ZxhKfjGdfK4PHtJRmlc/82p/gDt6S4mU2f76DhkuFOMhDvXuHMk0FQSL
 krJXzdiL5AS/EdLZqgU/a28g=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: from localhost.localdomain (147.136.157.2)
	by smtp.migadu.com with ESMTPS id 5cb25e1fa7d6522b;
	Mon, 24 Aug 2026 09:33:54 +0000
X-Mizu-Trace-ID: 5cb25e1fa7d6522b
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: Add a test for arena fault-in under memory.max
Date: Mon, 24 Aug 2026 17:29:55 +0800
Message-ID: <20260824093122.362135-5-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824093122.362135-1-jiayuan.chen@linux.dev>
References: <20260824093122.362135-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A child joins a memcg capped 64M above its post-load usage and faults an
arena in until it runs out of that budget.

With the fix the arena page comes from the sleepable allocator, so
hitting memory.max goes through the memcg OOM path and the child is
OOM-killed, which the test checks via memory.events "oom_kill".

Without the fix the test may still pass, because a concurrent blocking
allocation in the child (e.g. a COW fault on an inherited page) can hit
memory.max and OOM-kill it first. The goal is only that the fixed kernel
passes reliably.

  # test_progs -v -t arena_memcg
  serial_test_arena_memcg:PASS:child killed by signal
  serial_test_arena_memcg:PASS:memcg oom_kill
  #5       arena_memcg:OK

  # dmesg (the OOM comes from the arena sleepable allocation)
  test_progs invoked oom-killer: gfp_mask=GFP_KERNEL_ACCOUNT|__GFP_ZERO
   arena_vm_fault+0x4bc/0xad0
  Memory cgroup out of memory: Killed process 473 (test_progs)

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/arena_memcg.c    | 158 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
 2 files changed, 182 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
new file mode 100644
index 000000000000..c57b98494cfa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sys/user.h>
+#ifndef PAGE_SIZE /* on some archs it comes in sys/user.h */
+#include <unistd.h>
+#define PAGE_SIZE getpagesize()
+#endif
+
+#include "cgroup_helpers.h"
+#include "arena_memcg.skel.h"
+
+#define CG_PATH		"/arena_memcg"
+
+/* Budget the arena gets on top of whatever is already charged after load. */
+#define ARENA_BUDGET	(64 * 1024 * 1024)
+
+static void dump_memcg(int (*rd)(const char *, const char *, char *, size_t))
+{
+	char buf[512];
+
+	/*
+	 * memory.current reads 0 once the child has left the cgroup, so it only
+	 * carries information when dumped from the live child; memory.peak and
+	 * memory.events survive the child and tell the story either way.
+	 */
+	if (!rd(CG_PATH, "memory.current", buf, sizeof(buf)))
+		fprintf(stderr, "memory.current: %s", buf);
+	if (!rd(CG_PATH, "memory.max", buf, sizeof(buf)))
+		fprintf(stderr, "memory.max: %s", buf);
+	if (!rd(CG_PATH, "memory.peak", buf, sizeof(buf)))
+		fprintf(stderr, "memory.peak: %s", buf);
+	if (!rd(CG_PATH, "memory.events", buf, sizeof(buf)))
+		fprintf(stderr, "memory.events:\n%s", buf);
+	fflush(stderr);
+}
+
+/* Read one key from a flat keyed cgroup file, e.g. "oom_kill" in memory.events. */
+static long cg_read_key(const char *cg, const char *file, const char *key)
+{
+	char buf[512], *p;
+
+	if (read_cgroup_file(cg, file, buf, sizeof(buf)))
+		return -1;
+	p = strstr(buf, key);
+	if (!p)
+		return -1;
+	return strtol(p + strlen(key), NULL, 10);
+}
+
+void serial_test_arena_memcg(void)
+{
+	int cgroup_fd = -1, status, err;
+	const long ps = PAGE_SIZE;
+	char buf[64];
+	pid_t pid;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		return;
+
+	cgroup_fd = create_and_get_cgroup(CG_PATH);
+	if (!ASSERT_OK_FD(cgroup_fd, "create_and_get_cgroup"))
+		goto out;
+
+	/* No memory controller -> nothing to test. */
+	if (read_cgroup_file(CG_PATH, "memory.current", buf, sizeof(buf))) {
+		fprintf(stderr, "%s:SKIP:no memory controller\n", __func__);
+		test__skip();
+		goto out;
+	}
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out;
+	if (pid == 0) {
+		struct arena_memcg *cskel;
+		__u32 i, npages;
+		char *base;
+		size_t sz;
+		long cur;
+
+		/*
+		 * Do everything from the child: the arena vma is VM_DONTCOPY so
+		 * it would not survive fork(), only the child should be under the
+		 * limit so that a memcg OOM cannot pick test_progs, and a map is
+		 * charged to the memcg of the task that creates it - so join
+		 * before load. The cgroup work dir belongs to the parent that set
+		 * the environment up, so reach it with the _parent() helpers.
+		 * Errors are reported to the parent through the exit code, since
+		 * ASSERT_* in a forked child does not reach it.
+		 */
+		snprintf(buf, sizeof(buf), "%d", getpid());
+		if (write_cgroup_file_parent(CG_PATH, "cgroup.procs", buf))
+			_exit(2);
+
+		cskel = arena_memcg__open_and_load();
+		if (!cskel)
+			_exit(3);
+
+		base = bpf_map__initial_value(cskel->maps.arena, &sz);
+		if (!base)
+			_exit(4);
+		npages = bpf_map__max_entries(cskel->maps.arena);
+
+		/*
+		 * Cap only now, after load: everything but the fault-in is
+		 * charged, so the arena gets a fixed budget regardless of what
+		 * the load itself cost, and the load can never hit the limit.
+		 */
+		if (read_cgroup_file_parent(CG_PATH, "memory.current", buf, sizeof(buf)))
+			_exit(5);
+		cur = strtol(buf, NULL, 10);
+		snprintf(buf, sizeof(buf), "%ld", cur + ARENA_BUDGET);
+		if (write_cgroup_file_parent(CG_PATH, "memory.max", buf))
+			_exit(6);
+
+		for (i = 0; i < npages; i++)
+			base[(size_t)i * ps] = 1;
+		/* Faulted everything without dying: dump why (only under -v). */
+		dump_memcg(read_cgroup_file_parent);
+		_exit(0);
+	}
+
+	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid"))
+		goto out;
+
+	/* A non-zero exit means the child failed to set up; the code says where. */
+	if (WIFEXITED(status) && WEXITSTATUS(status)) {
+		ASSERT_OK(WEXITSTATUS(status), "child setup");
+		goto out;
+	}
+
+	/*
+	 * Faulting a valid arena address until memory.max is hit must not look
+	 * like an invalid access. Without the fix the fault path allocated with
+	 * the non-blocking allocator, turned its -ENOMEM into VM_FAULT_SIGSEGV,
+	 * and the child died with SIGSEGV on a valid address; now it is handled
+	 * by the memcg OOM path instead. A SIGKILL alone would not prove the
+	 * memcg OOM killer did it (a global OOM or an unrelated crash could also
+	 * kill the child), so check memory.events.oom_kill, which records the
+	 * memcg OOM and survives the child.
+	 */
+	if (!ASSERT_TRUE(WIFSIGNALED(status), "child killed by signal"))
+		goto out;
+	if (!ASSERT_GE(cg_read_key(CG_PATH, "memory.events", "oom_kill"), 1,
+		       "memcg oom_kill"))
+		dump_memcg(read_cgroup_file);
+out:
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_memcg.c b/tools/testing/selftests/bpf/progs/arena_memcg.c
new file mode 100644
index 000000000000..88259cfea06b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_memcg.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 50000); /* number of pages */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32); /* start of mmap() region */
+#else
+	__ulong(map_extra, 0x1ull << 44); /* start of mmap() region */
+#endif
+} arena SEC(".maps");
+
+SEC("syscall")
+int noop(void *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

