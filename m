Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794009595;
	b=048xgak1DBW9fRWSedfmKy+7saAw14yy1t0ZUDPA5Yn423z6aKw41AdsIpOyEQpp+DGq
	 whfWM3LXP8FKfKhqd7daM7L3GAaIV9YQ2C2u0MTzke/D9nlCWV8GlA55JYrOBeiUweCrA
	 iwh5OnzjJrWtUpkn0NVNnzPE6fl1BCgrnxFvTcrSqP6QZzivnCiMqkDrl6ZtyURl1Oz8v
	 6mRkVkXdeVSe2U5Y00Liy4JC1UXXjD0jn8jQHyY97HQkHupLE3a8PM6zBgR0TXQNiubve
	 qTR3J3cnKUM1PLSFQUr8V6CFwO6Ftr39Qf1nWdULbaOwnxMT0LiJKYvrSN/Zs/Ll05Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794009595;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hx+CFDT4ZjpW7I3BU2+P+GG/JKpTS1w9GaGMvfwJ3iY=;
	b=brNoM7Kzclh/fP2Jx/Lyf3i05wwYiUKdOuASgQoeAxjXj9/TqjT/WM4moghaCFtflbYl
	 dkHEigAYZKEkucWE15y6GGmBbUIp3l4t6RgejIhjMi7/YzC+/J19EwD1bvi5kk6Qw8VXI
	 v9KWFMLB8+K4DE3QNOwa4Iq7diIIFx01DGuvY0rxHDO++sBL7a5ruW1mIBSLVV/Fmg+q8
	 CRjz7wH7/5lD3GTHq7loFvXYui0WIx6/XyZtZLx2DfVGnsDxSdXAELGqx9xfY6/IkpmP/
	 Nh9H1kaOTGHR8ewcHxP4L9aW+5Ie9CFrjEdHG0zgDpivfwPxG/N3bmUNjRGQBLhqltw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=qq6Zd2j6;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DF6606A33A
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 23:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24DF6606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=qq6Zd2j6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794009587;
	bh=hx+CFDT4ZjpW7I3BU2+P+GG/JKpTS1w9GaGMvfwJ3iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qq6Zd2j6uHUrN+nxx0ecbAIUG4IN6Hyu8H9eAH8BLp0d6QG1bw9zoDjNgyreohRti
	 FmEwn5wIqGqE7c3spsECr6kwdfvMIH5Y6TlovMZ6c3ah9nghFI3Y0FrloCt6XrQeUg
	 c05bnll3ysVz4Y4n0NNlSpv1n0i1dGCOgh7gz2oNchL9d9RErv+MYAOaqb0/WC0qup
	 dctAp2Gsa31jti5AhtVV2chAii6b3kERysjX41HsKpKFU3f33Jv5zQ+6dLrsGfNdDH
	 9ybwx1I95MxA5HsxWZHC9JyEo8BVGLQwx05bNHzVmq+uM3/yPLKzcLfmj865ae/4Gw
	 htwmVPxeLLdbA==
Received: from thinkos.internal.efficios.com (unknown [64.58.40.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jLx4M3gS0zLxL;
	Fri, 06 Nov 2026 18:59:47 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	shuah@kernel.org,
	juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/5] selftests/futex: Test priority inheritance on PI futexes
Date: Fri,  6 Nov 2026 18:59:30 -0500
Message-Id: <20261106235931.1478800-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PI futex selftests check what FUTEX_LOCK_PI returns, behind owners
asleep: none checks the priority an owner runs at, nor waits behind an
owner that runs. Add futex_lock_pi_inherit. Its nine cases read from
/proc the priority each owner runs at as waiters block, time out, get a
signal or change their priority, along chains and as a waiter is
promoted to the top of its lock; check that a lock cycle, and a chain
one deeper than max_lock_depth, are refused with EDEADLK; and time a 1ms
timeout and a signal behind an owner spinning in userspace, 5ms late at
most on average. The priority cases need CAP_SYS_NICE and skip without
it.

On v7.4-rc1, in 8-CPU VMs, it fails promoted_waiter,
timeout_owner_running and signal_owner_running, in 2 VMs of 2; with
PREEMPT_RT and CONFIG_DEBUG_RT_MUTEXES, deadlock and max_lock_depth too,
and signal_owner_running in 1 VM of 2, the signals of the other handled
1.4ms late on average. Each case passes from the fix it covers, earlier
in this series, on, and the series passes the nine, with and without
PREEMPT_RT.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../futex/functional/futex_lock_pi_inherit.c  | 744 ++++++++++++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 4 files changed, 750 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_lock_pi_inherit.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 7c39d10b38e4..fb5bfd1387da 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 futex_lock_pi_exiting
+futex_lock_pi_inherit
 futex_numa_mpol
 futex_priv_hash
 futex_requeue
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a03bd5acba50..f32a05fc46d6 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -28,7 +28,8 @@ TEST_GEN_PROGS := \
 	futex_waitv \
 	futex_numa \
 	robust_list \
-	futex_lock_pi_exiting
+	futex_lock_pi_exiting \
+	futex_lock_pi_inherit
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/futex_lock_pi_inherit.c b/tools/testing/selftests/futex/functional/futex_lock_pi_inherit.c
new file mode 100644
index 000000000000..4f2a597980f5
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_lock_pi_inherit.c
@@ -0,0 +1,744 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * futex_lock_pi_inherit.c
+ *
+ * Priority inheritance on PI futexes as the scheduler applies it, the
+ * deadlocks FUTEX_LOCK_PI refuses, and waits on a PI futex whose owner
+ * keeps running.
+ *
+ * The other PI futex tests check what FUTEX_LOCK_PI returns. These check
+ * the priority each owner runs at, read from /proc (prio - 100: 20 for
+ * SCHED_OTHER at nice 0, -1 - n for SCHED_FIFO n), after a waiter blocks,
+ * times out, gets a signal or changes its priority, along a chain of owners
+ * blocked in turn, and when a waiter is promoted to the top of its lock;
+ * that a lock cycle, and a chain deeper than max_lock_depth, are refused
+ * with EDEADLK; and, behind an owner spinning in userspace, which has its
+ * top waiter spin in the kernel, that the waiter's timeout, or a signal to
+ * it, still ends its wait in time.
+ *
+ * The priority tests need CAP_SYS_NICE for SCHED_FIFO and skip without it;
+ * the depth test builds a chain one deeper than max_lock_depth, 1026
+ * threads by default; the running-owner tests need two CPUs, three for the
+ * signal.
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdatomic.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "futextest.h"
+#include "kselftest_harness.h"
+
+#define NSEC_PER_USEC	1000ULL
+#define NSEC_PER_MSEC	1000000ULL
+#define NSEC_PER_SEC	1000000000ULL
+
+#define PRIO_OTHER	20
+#define PRIO_FIFO(n)	(-1 - (n))
+
+static pid_t sys_gettid(void)
+{
+	return syscall(SYS_gettid);
+}
+
+static uint64_t now_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
+}
+
+/* An absolute CLOCK_REALTIME timeout @ns from now, as FUTEX_LOCK_PI takes. */
+static struct timespec abs_timeout(uint64_t ns)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+	ts.tv_sec += ns / NSEC_PER_SEC;
+	ts.tv_nsec += ns % NSEC_PER_SEC;
+	if (ts.tv_nsec >= (long)NSEC_PER_SEC) {
+		ts.tv_nsec -= NSEC_PER_SEC;
+		ts.tv_sec++;
+	}
+	return ts;
+}
+
+/* Field @field (1-based, as in proc(5)) of the stat line @buf, or -1000. */
+static int stat_field(char *buf, int field, char *state)
+{
+	char *p;
+	int i;
+
+	p = strrchr(buf, ')');
+	if (!p || !p[1] || !p[2])
+		return -1000;
+	if (state)
+		*state = p[2];
+	for (i = 2; p && i < field; i++)
+		p = strchr(p + 1, ' ');
+	return p ? atoi(p + 1) : -1000;
+}
+
+/* Field @field of /proc/self/task/@tid/stat, or -1000. */
+static int task_stat(pid_t tid, int field, char *state)
+{
+	char path[64], buf[1024];
+	ssize_t n;
+	int fd;
+
+	snprintf(path, sizeof(path), "/proc/self/task/%d/stat", tid);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1000;
+	n = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+	if (n <= 0)
+		return -1000;
+	buf[n] = '\0';
+	return stat_field(buf, field, state);
+}
+
+/* The priority @tid runs at. */
+static int task_prio(pid_t tid)
+{
+	return task_stat(tid, 18, NULL);
+}
+
+/* Wait up to 2s for @tid to run at @prio; the last priority read. */
+static int wait_prio(pid_t tid, int prio)
+{
+	uint64_t end = now_ns() + 2 * NSEC_PER_SEC;
+	int p;
+
+	while ((p = task_prio(tid)) != prio && now_ns() < end)
+		usleep(1000);
+	return p;
+}
+
+static int set_fifo(pid_t tid, int prio)
+{
+	struct sched_param sp = { .sched_priority = prio };
+
+	return prio ? sched_setscheduler(tid, SCHED_FIFO, &sp) :
+		      sched_setscheduler(tid, SCHED_OTHER, &sp);
+}
+
+/* SCHED_FIFO up to 80, the highest priority the tests use. */
+static bool can_fifo(void)
+{
+	if (set_fifo(0, 80))
+		return false;
+	set_fifo(0, 0);
+	return true;
+}
+
+/*
+ * A thread of the tests: it takes the locks of @hold, then blocks on @wait
+ * (none: it sleeps until released), with a timeout of @timeout_ns if not 0.
+ * @blocking is set just before it blocks, @tid once it runs.
+ */
+struct pi_thread {
+	pthread_t thread;
+	futex_t *hold[2];
+	futex_t *wait;
+	uint64_t timeout_ns;
+	int fifo;
+	atomic_int tid;
+	atomic_int blocking;
+	atomic_int done;
+	int ret;		/* 0 or the errno of the lock of @wait */
+	int err;		/* 0 or the errno of the first call that failed */
+};
+
+static futex_t release_word;
+
+static void release_all(void)
+{
+	release_word = 1;
+	futex_wake(&release_word, INT32_MAX, FUTEX_PRIVATE_FLAG);
+}
+
+/* Record the first call of @t that failed, with errno @err. */
+static void thread_fail(struct pi_thread *t, int err)
+{
+	if (!t->err)
+		t->err = err ? err : EINVAL;
+}
+
+static void *pi_thread_fn(void *arg)
+{
+	struct pi_thread *t = arg;
+	int held = 0;
+
+	atomic_store(&t->tid, sys_gettid());
+	if (t->fifo && set_fifo(0, t->fifo)) {
+		thread_fail(t, errno);
+		goto out;
+	}
+	for (; held < 2 && t->hold[held]; held++) {
+		if (futex_lock_pi(t->hold[held], NULL, 0, FUTEX_PRIVATE_FLAG)) {
+			thread_fail(t, errno);
+			goto unlock;
+		}
+	}
+	atomic_store_explicit(&t->blocking, 1, memory_order_release);
+	if (t->wait) {
+		struct timespec ts = abs_timeout(t->timeout_ns);
+
+		t->ret = futex_lock_pi(t->wait, t->timeout_ns ? &ts : NULL, 0,
+				       FUTEX_PRIVATE_FLAG) ? errno : 0;
+		if (!t->ret && futex_unlock_pi(t->wait, FUTEX_PRIVATE_FLAG))
+			thread_fail(t, errno);
+	} else {
+		while (!release_word) {
+			if (futex_wait(&release_word, 0, NULL, FUTEX_PRIVATE_FLAG) &&
+			    errno != EAGAIN && errno != EINTR) {
+				thread_fail(t, errno);
+				break;
+			}
+		}
+	}
+unlock:
+	while (held--)
+		if (futex_unlock_pi(t->hold[held], FUTEX_PRIVATE_FLAG))
+			thread_fail(t, errno);
+out:
+	atomic_store_explicit(&t->done, 1, memory_order_release);
+	return NULL;
+}
+
+/*
+ * Start @t and wait until it is asleep where it blocks; false if it could
+ * not be created, or did not block within 2s (it is then still to join).
+ */
+static bool start(struct pi_thread *t)
+{
+	uint64_t end = now_ns() + 2 * NSEC_PER_SEC;
+	pthread_attr_t attr;
+	char state = 0;
+	int err;
+
+	pthread_attr_init(&attr);
+	pthread_attr_setstacksize(&attr, 64 * 1024);
+	err = pthread_create(&t->thread, &attr, pi_thread_fn, t);
+	pthread_attr_destroy(&attr);
+	if (err) {
+		t->thread = pthread_self();
+		t->err = err;
+		atomic_store(&t->done, 1);
+		ksft_print_msg("pthread_create: %s\n", strerror(err));
+		return false;
+	}
+	while (now_ns() < end) {
+		if (atomic_load_explicit(&t->done, memory_order_acquire)) {
+			ksft_print_msg("a thread failed before blocking: %s\n",
+				       strerror(t->err ? t->err : t->ret));
+			return false;
+		}
+		if (atomic_load_explicit(&t->blocking, memory_order_acquire) &&
+		    task_stat(atomic_load(&t->tid), 3, &state) != -1000 && state == 'S')
+			return true;
+		usleep(1000);
+	}
+	ksft_print_msg("a thread did not block within 2s\n");
+	return false;
+}
+
+static void pi_thread_init(struct pi_thread *t, futex_t *hold0, futex_t *hold1,
+			   futex_t *wait, int fifo, uint64_t timeout_ns)
+{
+	memset(t, 0, sizeof(*t));
+	t->hold[0] = hold0;
+	t->hold[1] = hold1;
+	t->wait = wait;
+	t->fifo = fifo;
+	t->timeout_ns = timeout_ns;
+}
+
+/* Join @t; the error of pthread_join(), or of the first call of @t that failed, or 0. */
+static int join(struct pi_thread *t)
+{
+	int err = 0;
+
+	if (!pthread_equal(t->thread, pthread_self()))
+		err = pthread_join(t->thread, NULL);
+	return err ? err : t->err;
+}
+
+/* A SCHED_FIFO 50 waiter that times out boosts the owner, then no longer. */
+TEST(boost_timeout)
+{
+	futex_t l = FUTEX_INITIALIZER;
+	struct pi_thread o, w;
+
+	if (!can_fifo())
+		SKIP(return, "SCHED_FIFO not permitted: %s", strerror(errno));
+	release_word = 0;
+	pi_thread_init(&o, &l, NULL, NULL, 0, 0);
+	ASSERT_TRUE(start(&o));
+	pi_thread_init(&w, NULL, NULL, &l, 50, NSEC_PER_SEC);
+	ASSERT_TRUE(start(&w));
+	EXPECT_EQ(wait_prio(o.tid, PRIO_FIFO(50)), PRIO_FIFO(50));
+	EXPECT_EQ(join(&w), 0);
+	EXPECT_EQ(w.ret, ETIMEDOUT);
+	EXPECT_EQ(wait_prio(o.tid, PRIO_OTHER), PRIO_OTHER);
+	release_all();
+	EXPECT_EQ(join(&o), 0);
+}
+
+/* The owner follows a blocked waiter as it changes its priority. */
+TEST(waiter_priority_change)
+{
+	futex_t l = FUTEX_INITIALIZER;
+	struct pi_thread o, w;
+
+	if (!can_fifo())
+		SKIP(return, "SCHED_FIFO not permitted: %s", strerror(errno));
+	release_word = 0;
+	pi_thread_init(&o, &l, NULL, NULL, 0, 0);
+	ASSERT_TRUE(start(&o));
+	pi_thread_init(&w, NULL, NULL, &l, 50, 0);
+	ASSERT_TRUE(start(&w));
+	EXPECT_EQ(wait_prio(o.tid, PRIO_FIFO(50)), PRIO_FIFO(50));
+	ASSERT_EQ(set_fifo(w.tid, 70), 0);
+	EXPECT_EQ(task_prio(o.tid), PRIO_FIFO(70));
+	ASSERT_EQ(set_fifo(w.tid, 30), 0);
+	EXPECT_EQ(task_prio(o.tid), PRIO_FIFO(30));
+	ASSERT_EQ(set_fifo(w.tid, 0), 0);
+	EXPECT_EQ(task_prio(o.tid), PRIO_OTHER);
+	release_all();
+	EXPECT_EQ(join(&o), 0);
+	EXPECT_EQ(join(&w), 0);
+	EXPECT_EQ(w.ret, 0);
+}
+
+/*
+ * A waiter whose priority changes while another waiter is ahead of it on
+ * its lock, and that becomes the top waiter of that lock when the one
+ * ahead times out, is the one the owner inherits from, at its new
+ * priority: the owner holds L1, with W1 (SCHED_FIFO 80, timed) and behind
+ * it W2 (SCHED_FIFO 70, set to 10), and L2, with W3 (SCHED_FIFO 50). Once
+ * W1 times out, the owner runs at 50.
+ */
+TEST(promoted_waiter)
+{
+	futex_t l1 = FUTEX_INITIALIZER, l2 = FUTEX_INITIALIZER;
+	struct pi_thread o, w1, w2, w3;
+
+	if (!can_fifo())
+		SKIP(return, "SCHED_FIFO not permitted: %s", strerror(errno));
+	release_word = 0;
+	pi_thread_init(&o, &l1, &l2, NULL, 0, 0);
+	ASSERT_TRUE(start(&o));
+	pi_thread_init(&w3, NULL, NULL, &l2, 50, 0);
+	ASSERT_TRUE(start(&w3));
+	pi_thread_init(&w1, NULL, NULL, &l1, 80, NSEC_PER_SEC);
+	ASSERT_TRUE(start(&w1));
+	pi_thread_init(&w2, NULL, NULL, &l1, 70, 0);
+	ASSERT_TRUE(start(&w2));
+	EXPECT_EQ(wait_prio(o.tid, PRIO_FIFO(80)), PRIO_FIFO(80));
+	ASSERT_EQ(set_fifo(w2.tid, 10), 0);
+	EXPECT_EQ(task_prio(o.tid), PRIO_FIFO(80));
+	EXPECT_EQ(join(&w1), 0);
+	EXPECT_EQ(w1.ret, ETIMEDOUT);
+	EXPECT_EQ(wait_prio(o.tid, PRIO_FIFO(50)), PRIO_FIFO(50))
+		TH_LOG("the owner inherits from the wrong waiter");
+	release_all();
+	EXPECT_EQ(join(&o), 0);
+	EXPECT_EQ(join(&w2), 0);
+	EXPECT_EQ(join(&w3), 0);
+}
+
+/* T1's stat as the waiter's signal handler reads it, with open() and read() alone. */
+static char chain_path[64], chain_buf[1024];
+static _Atomic int chain_read = -1;
+
+static void chain_handler(int sig)
+{
+	int fd = open(chain_path, O_RDONLY);
+	ssize_t n = fd < 0 ? 0 : read(fd, chain_buf, sizeof(chain_buf) - 1);
+
+	if (fd >= 0)
+		close(fd);
+	atomic_store_explicit(&chain_read, n > 0 ? n : 0, memory_order_release);
+}
+
+/*
+ * A chain: T1 holds L1; T2 holds L2 and blocks on L1; W (SCHED_FIFO 60)
+ * blocks on L2. T2 and T1 run at 60 while W waits, and at their own
+ * priority again once it times out, or while it handles a signal.
+ */
+static void chain(struct __test_metadata *_metadata, bool timeout)
+{
+	futex_t l1 = FUTEX_INITIALIZER, l2 = FUTEX_INITIALIZER;
+	struct pi_thread t1, t2, w;
+	int n;
+
+	release_word = 0;
+	pi_thread_init(&t1, &l1, NULL, NULL, 0, 0);
+	ASSERT_TRUE(start(&t1));
+	pi_thread_init(&t2, &l2, NULL, &l1, 0, 0);
+	ASSERT_TRUE(start(&t2));
+	pi_thread_init(&w, NULL, NULL, &l2, 60, timeout ? NSEC_PER_SEC : 0);
+	ASSERT_TRUE(start(&w));
+	EXPECT_EQ(wait_prio(t1.tid, PRIO_FIFO(60)), PRIO_FIFO(60));
+	EXPECT_EQ(task_prio(t2.tid), PRIO_FIFO(60));
+	if (timeout) {
+		EXPECT_EQ(join(&w), 0);
+		EXPECT_EQ(w.ret, ETIMEDOUT);
+		EXPECT_EQ(wait_prio(t1.tid, PRIO_OTHER), PRIO_OTHER);
+		EXPECT_EQ(task_prio(t2.tid), PRIO_OTHER);
+	} else {
+		/* T2's own priority above the waiter's, then below it again. */
+		ASSERT_EQ(set_fifo(t2.tid, 70), 0);
+		EXPECT_EQ(task_prio(t1.tid), PRIO_FIFO(70));
+		ASSERT_EQ(set_fifo(t2.tid, 0), 0);
+		EXPECT_EQ(task_prio(t1.tid), PRIO_FIFO(60));
+		/* W out of the chain in its signal handler, back in after it. */
+		snprintf(chain_path, sizeof(chain_path), "/proc/self/task/%d/stat", t1.tid);
+		struct sigaction sa = { .sa_handler = chain_handler };
+		uint64_t end = now_ns() + 2 * NSEC_PER_SEC;
+
+		atomic_store(&chain_read, -1);
+		ASSERT_EQ(sigaction(SIGUSR1, &sa, NULL), 0);
+		ASSERT_EQ(pthread_kill(w.thread, SIGUSR1), 0);
+		while ((n = atomic_load_explicit(&chain_read, memory_order_acquire)) < 0 &&
+		       now_ns() < end)
+			usleep(1000);
+		ASSERT_GE(n, 0) TH_LOG("the signal was not handled within 2s");
+		chain_buf[n] = '\0';
+		EXPECT_EQ(stat_field(chain_buf, 18, NULL), PRIO_OTHER);
+		EXPECT_EQ(wait_prio(t1.tid, PRIO_FIFO(60)), PRIO_FIFO(60));
+		release_all();
+		EXPECT_EQ(join(&w), 0);
+		EXPECT_EQ(w.ret, 0);
+	}
+	release_all();
+	EXPECT_EQ(join(&t1), 0);
+	EXPECT_EQ(join(&t2), 0);
+}
+
+TEST(chain_timeout)
+{
+	if (!can_fifo())
+		SKIP(return, "SCHED_FIFO not permitted: %s", strerror(errno));
+	chain(_metadata, true);
+}
+
+TEST(chain_priority_change_and_signal)
+{
+	if (!can_fifo())
+		SKIP(return, "SCHED_FIFO not permitted: %s", strerror(errno));
+	chain(_metadata, false);
+}
+
+/* Two owners each blocking on the lock the other holds: EDEADLK. */
+TEST(deadlock)
+{
+	futex_t l1 = FUTEX_INITIALIZER, l2 = FUTEX_INITIALIZER;
+	struct pi_thread a;
+	int ret;
+
+	struct timespec ts;
+
+	release_word = 0;
+	pi_thread_init(&a, &l1, NULL, &l2, 0, 2 * NSEC_PER_SEC);
+	ASSERT_EQ(futex_lock_pi(&l2, NULL, 0, FUTEX_PRIVATE_FLAG), 0);
+	ASSERT_TRUE(start(&a));
+	ts = abs_timeout(NSEC_PER_SEC);
+	ret = futex_lock_pi(&l1, &ts, 0, FUTEX_PRIVATE_FLAG) ? errno : 0;
+	if (!ret)
+		EXPECT_EQ(futex_unlock_pi(&l1, FUTEX_PRIVATE_FLAG), 0);
+	EXPECT_EQ(futex_unlock_pi(&l2, FUTEX_PRIVATE_FLAG), 0);
+	EXPECT_EQ(join(&a), 0);
+	EXPECT_EQ(ret, EDEADLK)
+		TH_LOG("the second of an ABBA got %s, the first %s",
+		       strerror(ret), strerror(a.ret));
+	EXPECT_EQ(a.ret, 0);
+}
+
+/*
+ * A chain deeper than max_lock_depth: t[0] holds l[0], and t[i] holds l[i]
+ * and blocks on l[i - 1]. The depth of a chain walk counts the owners it
+ * finds blocked: t[i] blocking walks i - 1 of them, and is admitted up to
+ * t[depth + 1]; this thread, blocking on l[depth + 1], would walk depth + 1,
+ * and is refused with EDEADLK.
+ */
+#define MAX_DEPTH	4096
+static struct pi_thread depth_t[MAX_DEPTH + 2];
+static futex_t depth_l[MAX_DEPTH + 2];
+
+TEST(max_lock_depth)
+{
+	int depth = 0, i, n, blocked, ret = -1;
+	bool created = true;
+	struct timespec ts;
+	char buf[32] = "";
+	ssize_t len;
+	int fd;
+
+	fd = open("/proc/sys/kernel/max_lock_depth", O_RDONLY);
+	len = fd < 0 ? -1 : read(fd, buf, sizeof(buf) - 1);
+	if (fd >= 0)
+		close(fd);
+	if (len > 0)
+		depth = atoi(buf);
+	if (depth <= 0 || depth > MAX_DEPTH)
+		SKIP(return, "max_lock_depth %s not in 1 to %d", buf, MAX_DEPTH);
+	release_word = 0;
+	for (i = 0; i < depth + 2; i++) {
+		depth_l[i] = FUTEX_INITIALIZER;
+		pi_thread_init(&depth_t[i], &depth_l[i], NULL, i ? &depth_l[i - 1] : NULL, 0, 0);
+		if (!start(&depth_t[i]))
+			break;
+	}
+	blocked = n = i;
+	/* A thread that was created but did not block is still to join. */
+	if (i < depth + 2) {
+		if (pthread_equal(depth_t[i].thread, pthread_self()))
+			created = false;
+		else
+			n++;
+	}
+	if (blocked == depth + 2) {
+		ts = abs_timeout(NSEC_PER_SEC);
+		ret = futex_lock_pi(&depth_l[blocked - 1], &ts, 0, FUTEX_PRIVATE_FLAG) ? errno : 0;
+		if (!ret)
+			EXPECT_EQ(futex_unlock_pi(&depth_l[blocked - 1], FUTEX_PRIVATE_FLAG), 0);
+	}
+	release_all();
+	for (i = 0; i < n; i++)
+		EXPECT_EQ(join(&depth_t[i]), 0);
+	if (!created)
+		SKIP(return, "%d threads of the chain could not be created", depth + 2);
+	ASSERT_EQ(blocked, depth + 2)
+		TH_LOG("thread %d of the chain did not block", blocked);
+	EXPECT_EQ(ret, EDEADLK);
+	for (i = 1; i < blocked; i++)
+		EXPECT_EQ(depth_t[i].ret, 0);
+}
+
+/*
+ * The owner of a PI futex spinning in userspace on a CPU, its waiter on
+ * another: the waiter spins in the kernel while the owner runs, and its
+ * timeout, or a signal to it, must still end the wait in time.
+ */
+static atomic_int owner_stop, owner_holds, owner_err;
+static futex_t running_lock;
+
+/* Pin the calling thread on @cpu; 0 or an errno. */
+static int pin(int cpu)
+{
+	cpu_set_t set;
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+	return sched_setaffinity(0, sizeof(set), &set) ? errno : 0;
+}
+
+static void *running_owner(void *arg)
+{
+	int err = pin((long)arg);
+
+	if (!err && futex_lock_pi(&running_lock, NULL, 0, FUTEX_PRIVATE_FLAG))
+		err = errno;
+	if (err) {
+		atomic_store_explicit(&owner_err, err, memory_order_release);
+		return NULL;
+	}
+	atomic_store_explicit(&owner_holds, 1, memory_order_release);
+	while (!atomic_load_explicit(&owner_stop, memory_order_acquire))
+		;
+	if (futex_unlock_pi(&running_lock, FUTEX_PRIVATE_FLAG))
+		atomic_store_explicit(&owner_err, errno, memory_order_release);
+	return NULL;
+}
+
+/* @n CPUs this thread may run on, in @cpu, or false. */
+static bool pick_cpus(int *cpu, int n)
+{
+	cpu_set_t set;
+	int c, i = 0;
+
+	if (sched_getaffinity(0, sizeof(set), &set))
+		return false;
+	for (c = 0; c < CPU_SETSIZE && i < n; c++)
+		if (CPU_ISSET(c, &set))
+			cpu[i++] = c;
+	return i == n;
+}
+
+/* The owner, spinning on @cpu with running_lock held, in @o; false on a failure. */
+static bool start_running_owner(int cpu, pthread_t *o)
+{
+	uint64_t end = now_ns() + 2 * NSEC_PER_SEC;
+	int err;
+
+	running_lock = FUTEX_INITIALIZER;
+	atomic_store(&owner_stop, 0);
+	atomic_store(&owner_holds, 0);
+	atomic_store(&owner_err, 0);
+	err = pthread_create(o, NULL, running_owner, (void *)(long)cpu);
+	if (err) {
+		ksft_print_msg("pthread_create: %s\n", strerror(err));
+		return false;
+	}
+	while (!atomic_load_explicit(&owner_holds, memory_order_acquire) &&
+	       !atomic_load_explicit(&owner_err, memory_order_acquire) && now_ns() < end)
+		usleep(100);
+	if (atomic_load_explicit(&owner_holds, memory_order_acquire))
+		return true;
+	atomic_store_explicit(&owner_stop, 1, memory_order_release);
+	err = pthread_join(*o, NULL);
+	if (err)
+		ksft_print_msg("pthread_join: %s\n", strerror(err));
+	err = atomic_load(&owner_err);
+	ksft_print_msg("the owner did not take the lock: %s\n", err ? strerror(err) : "timeout");
+	return false;
+}
+
+/* Stop the owner; the error of pthread_join(), or of its first call that failed, or 0. */
+static int stop_running_owner(pthread_t o)
+{
+	int err;
+
+	atomic_store_explicit(&owner_stop, 1, memory_order_release);
+	err = pthread_join(o, NULL);
+	return err ? err : atomic_load(&owner_err);
+}
+
+/*
+ * 20 waits with a timeout of 1ms behind a running owner: 5ms late at most
+ * on average. A kernel that ends the spin of the waiter on its wakeup is
+ * tens of microseconds late; one that does not is late until something
+ * else reschedules one of the two CPUs, milliseconds to seconds.
+ */
+TEST(timeout_owner_running)
+{
+	uint64_t late = 0, t;
+	int cpu[2], i, ret;
+	pthread_t o;
+
+	if (!pick_cpus(cpu, 2))
+		SKIP(return, "two CPUs needed");
+	ASSERT_EQ(pin(cpu[1]), 0);
+	ASSERT_TRUE(start_running_owner(cpu[0], &o));
+	for (i = 0; i < 20; i++) {
+		struct timespec ts = abs_timeout(NSEC_PER_MSEC);
+
+		t = now_ns();
+		ret = futex_lock_pi(&running_lock, &ts, 0, FUTEX_PRIVATE_FLAG) ? errno : 0;
+		t = now_ns() - t;
+		EXPECT_EQ(ret, ETIMEDOUT);
+		late += t > NSEC_PER_MSEC ? t - NSEC_PER_MSEC : 0;
+	}
+	EXPECT_EQ(stop_running_owner(o), 0);
+	TH_LOG("a timeout of 1ms ends %llu us late on average",
+	       (unsigned long long)(late / 20 / NSEC_PER_USEC));
+	EXPECT_LT(late / 20, 5 * NSEC_PER_MSEC);
+}
+
+static _Atomic uint64_t handled_ns;
+static atomic_int waiter_tid, waiter_ret;
+
+static void running_handler(int sig)
+{
+	atomic_store(&handled_ns, now_ns());
+}
+
+static void *running_waiter(void *arg)
+{
+	int ret = pin((long)arg);
+
+	atomic_store(&waiter_tid, sys_gettid());
+	if (!ret)
+		ret = futex_lock_pi(&running_lock, NULL, 0, FUTEX_PRIVATE_FLAG) ? errno : 0;
+	if (!ret && futex_unlock_pi(&running_lock, FUTEX_PRIVATE_FLAG))
+		ret = errno;
+	atomic_store(&waiter_ret, ret);
+	return NULL;
+}
+
+/*
+ * Wait up to 2s for the waiter to be asleep on running_lock, as the futex
+ * word and its state say.
+ */
+static bool waiter_blocked(void)
+{
+	uint64_t end = now_ns() + 2 * NSEC_PER_SEC;
+	char state = 0;
+	pid_t tid;
+
+	while (now_ns() < end) {
+		tid = atomic_load(&waiter_tid);
+		if (tid && (running_lock & FUTEX_WAITERS) &&
+		    task_stat(tid, 3, &state) != -1000 && state == 'S')
+			return true;
+		usleep(100);
+	}
+	return false;
+}
+
+/*
+ * 10 signals to a waiter behind a running owner, sent from a third CPU
+ * once the waiter is asleep on the lock: handled within 5ms on average,
+ * as the timeouts above. A signal not handled within 2s counts for 2s.
+ */
+TEST(signal_owner_running)
+{
+	struct sigaction sa = { .sa_handler = running_handler };
+	uint64_t total = 0, t, end;
+	int cpu[3], i, err, n = 0;
+	bool blocked = true;
+	pthread_t o, w;
+
+	if (!pick_cpus(cpu, 3))
+		SKIP(return, "three CPUs needed");
+	ASSERT_EQ(sigaction(SIGUSR1, &sa, NULL), 0);
+	ASSERT_EQ(pin(cpu[2]), 0);
+	ASSERT_TRUE(start_running_owner(cpu[0], &o));
+	atomic_store(&waiter_tid, 0);
+	atomic_store(&waiter_ret, -1);
+	err = pthread_create(&w, NULL, running_waiter, (void *)(long)cpu[1]);
+	if (err) {
+		stop_running_owner(o);
+		ASSERT_EQ(err, 0) TH_LOG("pthread_create: %s", strerror(err));
+	}
+	for (i = 0; i < 10; i++) {
+		if (!waiter_blocked()) {
+			blocked = false;
+			break;
+		}
+		atomic_store(&handled_ns, 0);
+		t = now_ns();
+		EXPECT_EQ(pthread_kill(w, SIGUSR1), 0);
+		end = t + 2 * NSEC_PER_SEC;
+		while (!atomic_load(&handled_ns) && now_ns() < end)
+			usleep(50);
+		total += (atomic_load(&handled_ns) ? atomic_load(&handled_ns) : end) - t;
+		n++;
+	}
+	EXPECT_EQ(stop_running_owner(o), 0);
+	EXPECT_EQ(pthread_join(w, NULL), 0);
+	EXPECT_EQ(atomic_load(&waiter_ret), 0);
+	ASSERT_TRUE(blocked) TH_LOG("the waiter did not block on the lock");
+	TH_LOG("a signal is handled after %llu us on average",
+	       (unsigned long long)(total / n / NSEC_PER_USEC));
+	EXPECT_LT(total / n, 5 * NSEC_PER_MSEC);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index d1a681b798bd..ed37522af5c3 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -54,3 +54,6 @@ echo
 
 echo
 ./futex_lock_pi_exiting
+
+echo
+./futex_lock_pi_inherit
-- 
2.47.3

