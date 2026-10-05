Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838B374A06
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Oct 2026 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791184002; cv=none; b=OdtLucCmbAp7J8JTphYQRXsgrQvPauFXVrvVvZyhnXfShX1AnoRJn7FAPsQUPZcfc0/IFSGm7/Xjajorf+jE0v1RxpU3p3OS7/9wYhWJiNMIhMNQaj3Z44BVX5Tf31koMnBdJ6sFwnCKbpOyCvJiZNe2lNhV//A4F21eTmOfh78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791184002; c=relaxed/simple;
	bh=G4IEzobgfsKNObG/Hy6E+npwMk0v9FtMQFSITgNTZ6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AeuEapVNL0YBmI093tCO8ATjqCetDh+O+xuFWxLGkBFMuIK9fMJPZOYI0G4hVrH29G/qlspbyxYdsi/t1+36R0LjmDh8gHEqq3mDv/JTq7tW6SOpuhJYmuIpFNp24/WlXFKyM48CGlqNnT91BHbWV471nL90fnbylvsGPAS6FvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWWwedf9; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWWwedf9"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a0280d4f56so8171875e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 05 Oct 2026 00:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791183998; x=1791788798; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xfZ3u+8kppu334roBh57uG8qfuX2GjTQB+h2l+yzJBo=;
        b=lWWwedf9QEoVwTeTStvZ3qSmYmue5A90uIv+ECg8B0MXCCsEmcRbSOLqS1WsjKkXyc
         AHedOfUfcs6zCpUz9axrTbTDxX6Lwi/xdpO6lJax+h7UxeEkMaqIjnquAQcCAubMNTSB
         Z77Z4h+/OhEm7dCk/ONMSQMtC8U9aikG7k60yLXlP5n9Hq88Fp98Aqm7AmSbn7v0D2rf
         ZwHCcAxM1QKRcPHrZXvRBxvM1vieLwYArxcTF+78FS0+j33c02zBhS2nRdx8MLvQF2wh
         9yxYIQ//11lQ8TSgvmcbhjeGIpxa54Sl2DRVMVDNf4grbkVXaH9ipnZUjq/VNyxyTl/S
         EBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791183998; x=1791788798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xfZ3u+8kppu334roBh57uG8qfuX2GjTQB+h2l+yzJBo=;
        b=tHfix+2XDu74cvRmP9bvSfw96FqQeWM1bZ8wFD9Sp/Ng/pQKhCPTMqFkQjtNxcUi9R
         ShD1TvGGSa4d5GJFs46aIxhbJ8T/pzX1kpAGQQMwovLpR0UUTVJTtEXqjhF1HQiLxXBt
         EwKDsHCEEKVTX9bCVSyLfnd/ZNkW848zpzsjvW3z52erLhBgoRhJgpkoUTd4ad93m7oy
         libiHeUBivUUQTAzaW3yrzA3FmjaNBksgreUtyzLMTPIpyRGACkNmekKPIz1PRo2LzsW
         aiM+BcO8HxXWj2I6a0bw9R3/bdzmJn/+xx8YXoj/7L+jVRqODvTFKnoS/ZCr1pnTbGlu
         Xe1g==
X-Forwarded-Encrypted: i=1; AKwUvByUoKxeGS9I0nI3DGbDkX9+QVSwjtPtaxWbhsskcz104aiMa8Otd37QReqx4bOp7CWJi2qsRwVyT0mwfDWjng==@lists.linux.dev
X-Gm-Message-State: AFuF++kOOyMlVU51HMaUwGhy0/UbiXZtQdO3nUZUo21vx9u39TbfNmok
	u460BlrUG2UlkJrHzbK5RMqMH7vxwVwTAjnRPFB2QSNbFuZ9ndWT+YIU
X-Gm-Gg: AYBFou2qVT5z3NehKAPaZJG2PIeqNQqT4CrFZJs7mlYz4N1uggin8LL9DEoDq57yKE3
	dqg5NoV08XgVMEy3I6xHBkL3wNc1zDaJwJwLvabGka3gYuJKMXaNr+sD5XirJK/s56Ii6CPpq53
	BMsUAUeIknMXmDsX8Cj4ma8CyPZxeI50Ah5IxeKQOmYnTUz+H2QisOrKutX/2oMIFcnziB40K/p
	X6AqtirvUcXhLCQDTdia+5C4pJBwWyYHV8bEv6be/PaYJL5RT8PYVx5FXjyMhuEBBnriSEV1DAu
	qloMKxOIMDQ0+dE7LfQGli3ZpTYuojF+yS0OeTvNpelxEcFCTUFLxQjGfbKTRGBpgsfUAVnY0h2
	wwVYOlFa8BM/RNAYoDbMU+e1p34i1UE+Gm1NJyaQRFSG5RfrmxAt4Nn5iiSUrafkbnp0LzYwgf0
	apu66F0HBDIe/lbp8xZoSGTCXW9WcfXWeM8Q67FHGNV+//AG/EG9jRj7GcPu8MgxedVAC3gfSzf
	XtFpPYB+qhK2/0Go9IXShF5FcKizM/I+Er1S3qfRoMK93W6aOcR/K8nJoyaG2SQKjgd35S8lbXi
	u1oLC/U7a79VQz6UR6Px1yBju0jKMQaPSUK2A5VdlJOZinMm2mfhe33NUhDM5/DrgOL9k3ybYgy
	duw==
X-Received: by 2002:a05:600c:46cc:b0:4a0:258a:8de4 with SMTP id 5b1f17b1804b1-4a0274e9c3dmr145299735e9.4.1791183998159;
        Mon, 05 Oct 2026 00:06:38 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de. [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a16bcb9a21sm283461465e9.10.2026.10.05.00.06.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 00:06:37 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Stevens <stevensd@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 3/3] selftests/bpf: exercise task storage from hrtimer_start
Date: Mon,  5 Oct 2026 09:06:25 +0200
Message-Id: <20261005070625.8871-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261005070625.8871-1-kmehltretter@gmail.com>
References: <20261005070625.8871-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No BPF selftest creates task-local storage from a tracepoint which runs
while an hrtimer base raw lock is held.  On PREEMPT_RT, this can exercise
allocator rtmutexes inside a raw-lock section.

Attach a program to tp_btf/hrtimer_start for the test process.  Create and
delete task storage on every event and trigger 1,000 events with
timerfd_settime().  Detach the program before reading its counters, then
require at least one successful allocation and balanced attempt and
outcome counters.  Allocation failure remains valid for the best-effort
no-lock API.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 .../bpf/prog_tests/task_storage_hrtimer.c     | 50 +++++++++++++++++++
 .../bpf/progs/task_storage_hrtimer.c          | 48 ++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_storage_hrtimer.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_storage_hrtimer.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_storage_hrtimer.c b/tools/testing/selftests/bpf/prog_tests/task_storage_hrtimer.c
new file mode 100644
index 000000000000..216e66263bf6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_storage_hrtimer.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/timerfd.h>
+#include <unistd.h>
+
+#include <test_progs.h>
+#include "task_storage_hrtimer.skel.h"
+
+#define TRIGGER_COUNT 1000
+
+void test_task_storage_hrtimer(void)
+{
+	struct itimerspec timer = {
+		.it_value.tv_nsec = 1000000,
+	};
+	struct task_storage_hrtimer *skel;
+	int err, fd = -1, i;
+
+	skel = task_storage_hrtimer__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	skel->bss->target_tgid = getpid();
+	err = task_storage_hrtimer__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	fd = timerfd_create(CLOCK_MONOTONIC, TFD_CLOEXEC);
+	if (!ASSERT_GE(fd, 0, "timerfd_create"))
+		goto cleanup;
+
+	for (i = 0; i < TRIGGER_COUNT; i++) {
+		err = timerfd_settime(fd, 0, &timer, NULL);
+		if (!ASSERT_OK(err, "timerfd_settime"))
+			goto cleanup;
+	}
+
+	task_storage_hrtimer__detach(skel);
+
+	ASSERT_GE(skel->bss->seen, TRIGGER_COUNT, "seen");
+	ASSERT_EQ(skel->bss->attempted, skel->bss->seen, "attempted");
+	ASSERT_GT(skel->bss->succeeded, 0, "succeeded");
+	ASSERT_EQ(skel->bss->delete_errors, 0, "delete_errors");
+	ASSERT_EQ(skel->bss->attempted,
+		  skel->bss->succeeded + skel->bss->failed, "attempts");
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	task_storage_hrtimer__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/task_storage_hrtimer.c b/tools/testing/selftests/bpf/progs/task_storage_hrtimer.c
new file mode 100644
index 000000000000..a53c966f15b5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_storage_hrtimer.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, long);
+} task_storage SEC(".maps");
+
+u32 target_tgid;
+u64 seen;
+u64 attempted;
+u64 succeeded;
+u64 failed;
+u64 delete_errors;
+
+SEC("tp_btf/hrtimer_start")
+int BPF_PROG(on_hrtimer_start, struct hrtimer *timer,
+	     enum hrtimer_mode mode, bool was_armed)
+{
+	struct task_struct *task;
+	long *storage;
+
+	if (bpf_get_current_pid_tgid() >> 32 != target_tgid)
+		return 0;
+
+	seen++;
+	attempted++;
+	task = bpf_get_current_task_btf();
+	storage = bpf_task_storage_get(&task_storage, task, NULL,
+				       BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!storage) {
+		failed++;
+		return 0;
+	}
+
+	if (bpf_task_storage_delete(&task_storage, task))
+		delete_errors++;
+	else
+		succeeded++;
+
+	return 0;
+}
-- 
2.53.0

