Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897354;
	b=SPIT6kN1x/vdtd07Q41g5zsGEJiQUV9HMwW7J3jHepiNsC4eL10dzBev76r50z5UlwRq
	 DRQgkCEDlbov9DSCvGiwj/wDk5LZzZ3WnM+6PAZe59bbl7u2DEQ8jpxdcwqnRI9sh32TZ
	 rWtzgmoieAAALqyLQiI5m5SImfTRxp1chNo+5qKL8w/4iX++hOwIzCZpVi4ceMzZO31Go
	 7bqmNMN3f1l7IZQ8bMpe6QOtxKyTFJrsKSxtvnNFWMtZdqlL7xi9OR0HVYZETM1IvD3LY
	 WUHEjPNhy/AEpk7Ze7hX6LlH40bCy6FxW/LPcjx8HZsFfxttl5NaHy+T+LgWSqHl2Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+PH6pM0KO0GfjHgex8RdBS5eSN0Pih4B4kcJL+AwLBk=;
	b=c1RsjkONLdKTKrPw+IjUqBqGL3E/wo86Vs9BwoSqjt4fVsjAa+KkejltgBaoahCv88xA
	 1MkeXqJN4/fnxjt/QlkOn1o/o6y5DciGFAZlMt6HNYgoMmzYKlmzME99zq+BAFnpliA/F
	 DMhDL4rRZhplauvsnUdaep3bX3NAhvpoGktCElVIHjfY8hK8W92gMNyZ0Md8828FNa3no
	 81hzdM7KIzK0xURmI0r27p+awEE8Vc5yYgT+e2LZwxF4bByllYWOI3xHmZT6Q6XbdH7pG
	 Gc7PBC09Bx20kndlzStvDEBhx+6o/xSuNWRKRELUs33Z3BwvRoCe5f21JUzWsxOlTXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oeJvD/sH";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986BF606A32C
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 16:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 986BF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oeJvD/sH
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-491846221ffso683306f8f.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 08:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793897352; x=1794502152; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+PH6pM0KO0GfjHgex8RdBS5eSN0Pih4B4kcJL+AwLBk=;
        b=oeJvD/sHmzkw8euEDZHXciesrTUA+pkoxQejqyzE9kFJbN+YRClkcJ7fUDFsTSPS1i
         TjmgSpVNlSBQ1s4Hj4BH7uBNPjxPuhecupT7AaXpBuRwoWekqV8DAq3Vk8WBFk0hiTI/
         E2Br7rBFKZxJE2pluFlr8YeELV4FwK6QF1n+i3azoLfzzz0gPmnQbsINrU1vwoiYQ+dh
         tXhxCxFYpEvcxx/+vubTxYAA7mjAAj/lavO8JEDuUiSUPiCRtMTTcpp/r7XJPTPsVpfP
         wc0A2W/5wcGcoDXKjqYe+I8fsxVFCf4feRu6EZtWSLTeOcFJsKXNRESXKeC1wICexHuZ
         MjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897352; x=1794502152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+PH6pM0KO0GfjHgex8RdBS5eSN0Pih4B4kcJL+AwLBk=;
        b=PKKO9vSqj9yMg5ExKfx+oZF6gq5rmTcGC2KSMXbmjOIwRG8GVihHux6lrybxzAJXFP
         YhYTMoeqcwn0riCfixIv/5O8p3LSuOgBzUN+g+FgCwd/b9TOpKBVt4vhUJXf6fwMFHl1
         b/YD050NkKVaVP/nIqM4K5lBuNZGFg4ZF5S3noVhaSghn8MqBFtpxb0NMfhJdedPiBa3
         DSdymMQJf5/8m34PgB8O6VyJnjKFIHiNxQ7C84reQS3b1j+R0o++HdzDVmuV8fZ+TGEh
         t2qXFqsWFGgaT/801wQWneFB9NJYQN0rs7xWZ5GLS8KGiDEfwNaQE1pyUKoVYq8SVsBt
         gquw==
X-Forwarded-Encrypted: i=1; AKwUvBx6hcjnsjAGv333FJFZtauGBkzcDJLCjkcKLuzHfg5IvP1NVAMw097ZLscv7+dyt8hZlWLJGjqTOTw0uZ85Jg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9FkixHjB31Aj0qX6LApgNLbsK7EDXFvWu9erytZHq9WXmQ9Nzu
	q0HTDLmc0Kye0wb/tFjXOCA2wGaBAZoi7kp17dYnRTkTN8MOeTKXN1RO
X-Gm-Gg: AYBFou1L2z/BfUCSQIFJPHT95XMQPgUkbifpZllCznermCz9bin9gNO0TP+h+zqwOno
	t6TOYTK+OeSkD5h8zsVrR6l3y/8GLSgbomPrst4uAWsjQBc65OwhJXI7EiLsdyUfGFWyDxV43js
	Hk35zd+qIdYXq5O+4j/OGwQXoxXTK3d1JsFAZF8xMKxLK+8cmeSDvWDzBhfTwBDE86o/+XytqRr
	tWzyFj4y9188yWQml2KbpeQEW2PjEuB9XnvMl4ebnrFA9nxDPGFP2CBtn/4ohIg2enNhNF7QkgD
	rlfeLrvqHDieCwRK6AdxoEkYpRJTVim+SnX2AQXlDBXaQfZiwbDyoGfJHWu9f6Uyg6w3ARU/jaL
	A9eaqXv5JG0HzS4R3G1jVb3s56ocr5p9v3dWs4G6rAq1rK9YdREbeUYfzr9e6JZd6ylrq9oKTyw
	/UexhzuY6y4sbjQkFN8EOVgkYjQ6vnXWUaF3hZZw3vufun2UgkrWmOE6az2DpGA+NZhQOsdFTpE
	igYj1NKji6A1pBLJ5PFmiYk4zywt1WrVVaRUI8fyfS+UQyTzwqV+vgHWJZlnbb/HRwTU6aIsnoC
	9o3FeykOminl59TBuyOqSi14IYI6MlUrbPlh3UbbjhOXhR7NGe5J0Zfe6Yl4o99dPg3RFSYsQQD
	0ky4b40Y=
X-Received: by 2002:a05:6000:604:b0:48e:679a:4aeb with SMTP id ffacd0b85a97d-49272a3a85cmr451564f8f.3.1793897351596;
        Thu, 05 Nov 2026 08:49:11 -0800 (PST)
Received: from andreayoga.localdomain ([151.43.242.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda20935sm10478746f8f.54.2026.11.05.08.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:49:11 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Dario Faggioli <raistlin@linux.it>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH] sched/deadline: Check SCHED_DEADLINE affinity under the rq lock
Date: Thu,  5 Nov 2026 17:48:43 +0100
Message-ID: <20261105164856.29698-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A task can end up SCHED_DEADLINE with an affinity narrower than its root
domain when sched_setaffinity() and sched_setattr() race on it. Both
calls succeed, although each fails when made after the other:
sched_setattr() with -EPERM, sched_setaffinity() with -EBUSY.

__sched_setaffinity() calls dl_task_check_affinity() before
__set_cpus_allowed_ptr() takes task_rq_lock(), whereas
__sched_setscheduler() runs its admission test and switches the policy
under a single task_rq_lock(). So both calls can pass their checks:

  CPU 1: sched_setaffinity(p, cpu0)    CPU 2: sched_setattr(p, DEADLINE)

  dl_task_check_affinity()
    !task_has_dl_policy(p): return 0
                                       task_rq_lock()
                                       admission test passes
                                       p->policy = SCHED_DEADLINE
                                       task_rq_unlock()
  __set_cpus_allowed_ptr()
    task_rq_lock()
    p->cpus_mask = cpu0

The window includes CPU 1 spinning on task_rq_lock() while CPU 2 holds
it. With one thread narrowing a sleeping task to CPU 0 while another
makes it SCHED_DEADLINE, 923514, 959547 and 983997 of 1000000 rounds
ended with both calls succeeding on three boots of a 4-CPU guest.

Move the check into __set_cpus_allowed_ptr_locked(), next to the
PF_NO_SETAFFINITY re-check, under the same lock as the admission test.
Whichever call takes task_rq_lock() second then sees the other's
result: sched_setaffinity() fails with -EBUSY if p is already
SCHED_DEADLINE, and sched_setattr() fails with -EPERM if p's affinity
is already cpu0.

A new SCA_DL_CHECK flag selects the check, and only
__sched_setaffinity() sets it, so sched_setaffinity() and
relax_compatible_cpus_allowed_ptr() keep the check and other callers
stay unchecked. restrict_cpus_allowed_ptr() already does its deadline
check this way.

__sched_setaffinity() clears SCA_DL_CHECK before the second
__set_cpus_allowed_ptr() call it makes after racing with a cpuset
update, so the cpuset mask still wins there, as it does when
cpuset_update_tasks_cpumask() narrows a deadline task. SCA_CHECK stays
set for the PF_NO_SETAFFINITY re-check.

With this applied, the same test ends with both calls succeeding in 0
of 1000000 rounds on each of three boots, and sched_setaffinity()
fails with -EBUSY whenever it loses.

The race was reported by Sebastian. The fix was written with the help
of an LLM.

Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Closes: https://lore.kernel.org/20261103081149.DuyWNhVe@linutronix.de
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Cc: stable@vger.kernel.org
---
Sebastian reported this while reviewing [1]. The two patches are
independent and apply in either order.

This conflicts with patch 16 of [2], which also adds an SCA_ flag as
0x10 after SCA_USER. Whichever goes in second needs the next free bit,
not only a textual merge.

Tested on v7.4-rc1, on a 4-CPU x86_64 guest, with the program below,
which narrows a sleeping task to CPU 0 from one thread while another
makes it SCHED_DEADLINE, 1000000 rounds per boot.

It uses a 2us/1s reservation and one run per boot because tasks leaving
SCHED_DEADLINE while asleep leak total_bw [3]. A run raises total_bw
from 209712 to about 2.2M, still under the admission cap.

  // SPDX-License-Identifier: GPL-2.0
  // Race sched_setaffinity(one CPU) against sched_setattr(SCHED_DEADLINE)
  // on the same task. At most one of them should succeed: either the task
  // becomes DL first and the narrowing is refused with -EBUSY, or it is
  // narrowed first and admission is refused with -EPERM.
  //
  // Build: gcc -O2 -Wall -static -pthread -o repro repro.c
  // Run as root: ./repro [rounds]   (default 1000000)
  // Exit: 0 race not seen, 1 a round ended with both succeeding,
  //       2 setup failed or results unreliable.
  //
  // Run it from a task allowed on its whole root domain, and keep it to one
  // run of <= 1000000 rounds per boot: switching the sleeping victim back
  // to SCHED_OTHER leaks its total_bw each round (lore
  // 2b5fb3f22bca6aa383be8f4781923392@kernel.org), and once bandwidth runs
  // out sched_setattr() fails with -EBUSY, which this reports as exit 2.
  #define _GNU_SOURCE
  #include <errno.h>
  #include <pthread.h>
  #include <sched.h>
  #include <stdatomic.h>
  #include <stdint.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/syscall.h>
  #include <unistd.h>

  struct attr {
  	uint32_t size, policy;
  	uint64_t flags;
  	int32_t nice;
  	uint32_t prio;
  	uint64_t runtime, deadline, period;
  };

  static atomic_int go, done;
  static volatile pid_t target;
  static int ret_aff;
  static cpu_set_t one, all;

  static int setattr(uint32_t policy)
  {
  	struct attr a = { .size = sizeof(a), .policy = policy };

  	if (policy == 6) {	/* SCHED_DEADLINE, 2us every 1s */
  		a.runtime = 2000;
  		a.deadline = a.period = 1000000000;
  	}
  	return syscall(SYS_sched_setattr, target, &a, 0) ? errno : 0;
  }

  static void *victim(void *arg)
  {
  	target = syscall(SYS_gettid);
  	for (;;)
  		pause();
  	return arg;
  }

  static void *affiner(void *arg)
  {
  	for (int round = 1; ; round++) {
  		while (atomic_load(&go) < round)
  			;
  		ret_aff = sched_setaffinity(target, sizeof(one), &one) ? errno : 0;
  		atomic_fetch_add(&done, 1);
  	}
  	return arg;
  }

  int main(int argc, char **argv)
  {
  	long rounds = argc > 1 ? atol(argv[1]) : 1000000;
  	long both = 0, aff = 0, dl = 0, neither = 0;
  	long dl_eperm = 0, aff_ebusy = 0, dl_ebusy = 0;
  	pthread_t tv, ta;
  	int ret_dl;

  	if (rounds <= 0) {
  		fprintf(stderr, "rounds must be positive\n");
  		return 2;
  	}

  	/* Narrow to the first CPU we may run on, reset to all of them */
  	if (sched_getaffinity(0, sizeof(all), &all)) {
  		perror("sched_getaffinity");
  		return 2;
  	}
  	CPU_ZERO(&one);
  	for (int cpu = 0; cpu < CPU_SETSIZE; cpu++) {
  		if (CPU_ISSET(cpu, &all)) {
  			CPU_SET(cpu, &one);
  			break;
  		}
  	}

  	pthread_create(&tv, NULL, victim, NULL);
  	while (!target)
  		usleep(100);

  	ret_dl = setattr(6);
  	if (ret_dl) {
  		fprintf(stderr, "sched_setattr(SCHED_DEADLINE): %s (not root, affinity narrower than the root domain, or no DL bandwidth left?)\n",
  			strerror(ret_dl));
  		return 2;
  	}
  	ret_dl = setattr(0);
  	if (ret_dl) {
  		fprintf(stderr, "sched_setattr(SCHED_OTHER): %s\n", strerror(ret_dl));
  		return 2;
  	}

  	pthread_create(&ta, NULL, affiner, NULL);

  	for (long i = 1; i <= rounds; i++) {
  		if (setattr(0) || sched_setaffinity(target, sizeof(all), &all)) {
  			perror("reset");
  			return 2;
  		}
  		atomic_store(&go, i);
  		ret_dl = setattr(6);
  		while (atomic_load(&done) < i)
  			;
  		dl_ebusy += ret_dl == EBUSY;
  		if (!ret_aff && !ret_dl) {
  			cpu_set_t cur;

  			sched_getaffinity(target, sizeof(cur), &cur);
  			if (both++ < 5)
  				printf("round %ld: both succeeded, policy %d, %d CPU(s) allowed\n",
  				       i, sched_getscheduler(target), CPU_COUNT(&cur));
  		} else if (!ret_aff) {
  			aff++;
  			dl_eperm += ret_dl == EPERM;
  		} else if (!ret_dl) {
  			dl++;
  			aff_ebusy += ret_aff == EBUSY;
  		} else {
  			neither++;
  		}
  	}
  	/* A throttled 2us/1s deadline task would take ages to exit */
  	setattr(0);

  	printf("%ld rounds: %ld setaffinity won (setattr -EPERM %ld), %ld setattr won (setaffinity -EBUSY %ld), %ld neither, %ld both succeeded\n",
  	       rounds, aff, dl_eperm, dl, aff_ebusy, neither, both);
  	if (dl_ebusy) {
  		fprintf(stderr, "sched_setattr() failed with -EBUSY in %ld rounds: DL bandwidth exhausted, results unreliable\n",
  			dl_ebusy);
  		return 2;
  	}
  	return both ? 1 : 0;
  }

Also tested the cpuset retry in __sched_setaffinity() with the program
below, which shrinks a cpuset from 0-3 to 0-2 while
sched_setaffinity(0-3) runs on a deadline task in that cpuset. The task
never ended up allowed on CPU 3 (0 of 100000 rounds on each of 10 boots,
with the retry path taken 299 times in all). Without the SCA_DL_CHECK
clear before the retry, it was left on CPU 3 in 8 of 10 boots (27
rounds out of 275 retries): the retry only decides the outcome when
cpuset_update_tasks_cpumask() narrows the task before
sched_setaffinity() widens it again.

  // SPDX-License-Identifier: GPL-2.0
  // Race sched_setaffinity(all CPUs) on a SCHED_DEADLINE task against a
  // shrink of its cpuset that drops the highest CPU. The shrunk cpuset
  // should win: count rounds where the task is still allowed on the
  // dropped CPU after both have returned.
  //
  // Build: gcc -O2 -Wall -static -pthread -o cpuset-race cpuset-race.c
  // Run as root: ./cpuset-race [rounds]   (default 100000)
  // Exit: 0 task never left outside its cpuset, 1 it was in some round,
  //       2 setup failed, or no round reached the cpuset retry in
  //       __sched_setaffinity() (seen as -EINVAL).
  //
  // Needs cgroup2 at /sys/fs/cgroup with the cpuset controller available,
  // at least 2 CPUs, and a task allowed on its whole root domain. If the
  // root cgroup does not have cpuset enabled, it is enabled for the run
  // and disabled again afterwards.
  #define _GNU_SOURCE
  #include <errno.h>
  #include <fcntl.h>
  #include <pthread.h>
  #include <sched.h>
  #include <signal.h>
  #include <stdatomic.h>
  #include <stdint.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/stat.h>
  #include <sys/syscall.h>
  #include <sys/wait.h>
  #include <unistd.h>

  #define SUBTREE "/sys/fs/cgroup/cgroup.subtree_control"
  #define CG "/sys/fs/cgroup/dltest"

  struct attr {
  	uint32_t size, policy;
  	uint64_t flags;
  	int32_t nice;
  	uint32_t prio;
  	uint64_t runtime, deadline, period;
  };

  static atomic_int go, done;
  static pid_t victim;
  static int ret_aff;
  static cpu_set_t all;

  static int setattr(uint32_t policy)
  {
  	struct attr a = { .size = sizeof(a), .policy = policy };

  	if (policy == 6) {	/* SCHED_DEADLINE, 2us every 1s */
  		a.runtime = 2000;
  		a.deadline = a.period = 1000000000;
  	}
  	return syscall(SYS_sched_setattr, victim, &a, 0) ? errno : 0;
  }

  static int put(const char *path, const char *val)
  {
  	int fd = open(path, O_WRONLY);
  	int ret = 0;

  	if (fd < 0 || write(fd, val, strlen(val)) < 0) {
  		fprintf(stderr, "write %s=%s: %s\n", path, val, strerror(errno));
  		ret = -1;
  	}
  	if (fd >= 0)
  		close(fd);
  	return ret;
  }

  /* Is cpuset already in the root cgroup's subtree_control? */
  static int cpuset_enabled(void)
  {
  	char buf[256], *tok, *save;
  	FILE *f = fopen(SUBTREE, "r");
  	int found = 0;

  	if (!f)
  		return 0;
  	if (fgets(buf, sizeof(buf), f)) {
  		for (tok = strtok_r(buf, " \n", &save); tok;
  		     tok = strtok_r(NULL, " \n", &save))
  			found |= !strcmp(tok, "cpuset");
  	}
  	fclose(f);
  	return found;
  }

  /* Format @set as a comma-separated cpuset.cpus list */
  static void cpulist(const cpu_set_t *set, char *buf, size_t len)
  {
  	size_t n = 0;

  	buf[0] = '\0';
  	for (int cpu = 0; cpu < CPU_SETSIZE && n < len; cpu++)
  		if (CPU_ISSET(cpu, set))
  			n += snprintf(buf + n, len - n, "%s%d", n ? "," : "", cpu);
  }

  static void *affiner(void *arg)
  {
  	for (int round = 1; ; round++) {
  		while (atomic_load(&go) < round)
  			;
  		ret_aff = sched_setaffinity(victim, sizeof(all), &all) ? errno : 0;
  		atomic_fetch_add(&done, 1);
  	}
  	return arg;
  }

  int main(int argc, char **argv)
  {
  	long rounds = argc > 1 ? atol(argv[1]) : 100000;
  	long bad = 0, ok = 0, einval = 0, ebusy = 0, other = 0;
  	char full[4096], shrunk[4096], buf[32];
  	cpu_set_t less;
  	int drop = -1, ret = 2, added = 0, err;
  	pthread_t t;

  	if (rounds <= 0) {
  		fprintf(stderr, "rounds must be positive\n");
  		return 2;
  	}

  	/* The cpuset starts on all CPUs we may run on and drops the highest */
  	if (sched_getaffinity(0, sizeof(all), &all)) {
  		perror("sched_getaffinity");
  		return 2;
  	}
  	if (CPU_COUNT(&all) < 2) {
  		fprintf(stderr, "need at least 2 CPUs\n");
  		return 2;
  	}
  	less = all;
  	for (int cpu = 0; cpu < CPU_SETSIZE; cpu++)
  		if (CPU_ISSET(cpu, &all))
  			drop = cpu;
  	CPU_CLR(drop, &less);
  	cpulist(&all, full, sizeof(full));
  	cpulist(&less, shrunk, sizeof(shrunk));

  	if (!cpuset_enabled()) {
  		if (put(SUBTREE, "+cpuset"))
  			return 2;
  		added = 1;
  	}
  	if (mkdir(CG, 0755) && errno != EEXIST) {
  		perror("mkdir " CG);
  		goto out_controller;
  	}
  	if (put(CG "/cpuset.cpus", full))
  		goto out_rmdir;

  	victim = fork();
  	if (victim < 0) {
  		perror("fork");
  		goto out_rmdir;
  	}
  	if (!victim) {
  		for (;;)
  			pause();
  	}
  	snprintf(buf, sizeof(buf), "%d", victim);
  	if (put(CG "/cgroup.procs", buf))
  		goto out_kill;
  	err = setattr(6);
  	if (err) {
  		fprintf(stderr, "sched_setattr(SCHED_DEADLINE): %s (not root, affinity narrower than the root domain, or no DL bandwidth left?)\n",
  			strerror(err));
  		goto out_kill;
  	}

  	pthread_create(&t, NULL, affiner, NULL);

  	for (long i = 1; i <= rounds; i++) {
  		cpu_set_t cur;

  		/* The cpuset puts the victim back on all CPUs */
  		if (put(CG "/cpuset.cpus", full))
  			goto out_kill;
  		atomic_store(&go, i);
  		/* Races with sched_setaffinity() */
  		if (put(CG "/cpuset.cpus", shrunk))
  			goto out_kill;
  		while (atomic_load(&done) < i)
  			;
  		if (sched_getaffinity(victim, sizeof(cur), &cur)) {
  			perror("sched_getaffinity(victim)");
  			goto out_kill;
  		}
  		if (CPU_ISSET(drop, &cur) && bad++ < 3)
  			printf("round %ld: cpuset %s but task allowed on CPU %d, setaffinity errno %d\n",
  			       i, shrunk, drop, ret_aff);
  		if (!ret_aff)
  			ok++;
  		else if (ret_aff == EINVAL)
  			einval++;
  		else if (ret_aff == EBUSY)
  			ebusy++;
  		else
  			other++;
  	}

  	printf("%ld rounds: setaffinity ok %ld, -EINVAL %ld, -EBUSY %ld, other %ld; task outside cpuset in %ld\n",
  	       rounds, ok, einval, ebusy, other, bad);
  	if (bad) {
  		ret = 1;
  	} else if (!einval) {
  		fprintf(stderr, "no sched_setaffinity() reached the cpuset retry (-EINVAL): race not exercised\n");
  		ret = 2;
  	} else {
  		ret = 0;
  	}

  out_kill:
  	/* A throttled 2us/1s deadline task would take ages to exit */
  	setattr(0);
  	kill(victim, SIGKILL);
  	waitpid(victim, NULL, 0);
  out_rmdir:
  	rmdir(CG);
  out_controller:
  	if (added)
  		put(SUBTREE, "-cpuset");
  	return ret;
  }

I can add both programs to sched-deadline-tests [4] if that helps.

Both programs also pass with lockdep (PROVE_LOCKING,
PROVE_RAW_LOCK_NESTING, DEBUG_ATOMIC_SLEEP), and on PREEMPT_RT with the
same options plus DEBUG_RT_MUTEXES, with no lockdep reports.

On top of [1], with and without PREEMPT_RT, the first program ended
with both calls succeeding in 0 of 1000000 rounds on each of three
boots, and the second never left the task allowed on CPU 3 (0 of 100000
rounds on each of five boots, with the retry path taken 90 times in all
without PREEMPT_RT and 109 with it). Both also pass there with lockdep,
plus DEBUG_RT_MUTEXES on PREEMPT_RT, with no lockdep reports.

Not tested: the arm64 asymmetric 32-bit path through
relax_compatible_cpus_allowed_ptr().

The patch applies to v6.18 and later. Older stable trees need a manual
backport: v6.12 has different context, before v6.11 the
__sched_setaffinity() hunk belongs in kernel/sched/core.c, and trees
older than v6.2 lack struct affinity_context, added by commit
713a2e21a513 ("sched: Introduce affinity_context").

[1] https://lore.kernel.org/20261102135420.244745-1-parri.andrea@gmail.com/
[2] https://lore.kernel.org/20261104211207.1392343-1-mathieu.desnoyers@efficios.com/
[3] https://lore.kernel.org/2b5fb3f22bca6aa383be8f4781923392@kernel.org/
[4] https://github.com/jlelli/sched-deadline-tests

 kernel/sched/core.c     | 11 +++++++++++
 kernel/sched/sched.h    |  1 +
 kernel/sched/syscalls.c | 12 +++++++-----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8ca..b12f46bf7c862 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3195,6 +3195,17 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 		goto out;
 	}
 
+	/*
+	 * Check under the same lock that __sched_setscheduler() holds for
+	 * its admission test, so that p cannot become SCHED_DEADLINE
+	 * between this check and the mask update below.
+	 */
+	if (ctx->flags & SCA_DL_CHECK) {
+		ret = dl_task_check_affinity(p, ctx->new_mask);
+		if (ret)
+			goto out;
+	}
+
 	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
 		if (cpumask_equal(&p->cpus_mask, ctx->new_mask)) {
 			if (ctx->flags & SCA_USER)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c7c5633524a3..963b7cd6aa5cd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2953,6 +2953,7 @@ extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
 #define SCA_MIGRATE_DISABLE	0x02
 #define SCA_MIGRATE_ENABLE	0x04
 #define SCA_USER		0x08
+#define SCA_DL_CHECK		0x10
 
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 45a127deeadd9..0f4397d9b3370 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1152,11 +1152,7 @@ int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 	cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
 
 	ctx->new_mask = new_mask;
-	ctx->flags |= SCA_CHECK;
-
-	retval = dl_task_check_affinity(p, new_mask);
-	if (retval)
-		goto out_free_new_mask;
+	ctx->flags |= SCA_CHECK | SCA_DL_CHECK;
 
 	retval = __set_cpus_allowed_ptr(p, ctx);
 	if (retval)
@@ -1185,6 +1181,12 @@ int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
 			if (empty)
 				cpumask_copy(new_mask, cpus_allowed);
 		}
+
+		/*
+		 * The cpuset mask must win here, as it does when
+		 * cpuset_update_tasks_cpumask() sets it on a deadline task.
+		 */
+		ctx->flags &= ~SCA_DL_CHECK;
 		__set_cpus_allowed_ptr(p, ctx);
 		retval = -EINVAL;
 	}
-- 
2.53.0

