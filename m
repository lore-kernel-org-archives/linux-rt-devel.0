Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627173;
	b=1Cb7IEl7BS+FHVtzgWmrC1QC+ktPvo88lfc5iKo3MS6YVCGJmTkiY5cvGbhuwUvHzKgm
	 WAJNmhnJ/8x6xoMXy8+Un+Cj46UjqQwCnC17MTfNfjGRmLXXuXJFmLZa7MRzi4CF7diDS
	 WZHTJpgAtRNtD8lkEnL0uAmFlrf0T114XQaNZTZRjFpjJrPEyzeqoA1LsCcwhl/lzdG/j
	 0EkOWLJVx4Bv4vIMovP6zooCS1TAj87iEDaFWv1qxML3zjzljEMr1NZXYaJFKLoM9b3Ls
	 I4KcbO2vOg9LVxpdWHG+CNeq9e1QpFTP+lvpsrJy2+hzx/uXj0NYWW/c1QrFohS8+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iIKunQE+SicAhyjZQ/MMzEjIQWaAEW2rMinTZr7v7uI=;
	b=dyHOsX2bUXV1F3dZ1YlKMH6MfBhVkDaLG5q+EpSZbryk0lm95veUv6/j4h0m6uYmDc3B
	 KEdbnY/y+HA4IW6OkzAcA01jHsqwWu0uacO4xVPYl2MX/xwl832ZIL7PGmifZIKHyfFq6
	 A8YjV5N7+onuvWNJHE2wALXNJE+x104aMbtHn8fJOOE7CxZbdcpS1ND7+LXDKldpF21s/
	 swXu6vn2qno+M5qmZ4dAfOWhrGbmj/noF66mDd43ji96z1YJ1OJKq0jsL9jslQfAD9HUF
	 EZDdD279x4HXcQjKgnEuqQloXXGrRGA9H0hzpJaSkBh+fY50I51i+gzipy6dVPPahGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTIdO7nD;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D3606A326
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Nov 2026 13:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D59D3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTIdO7nD
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so34725505e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Nov 2026 05:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793627171; x=1794231971; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iIKunQE+SicAhyjZQ/MMzEjIQWaAEW2rMinTZr7v7uI=;
        b=GTIdO7nDFHSSNpCOrNa+XUpCb/uC++GiHuMMDdX49M5hp9GRTFW5mhkvVXf6T3kdyz
         J+ZUsVN6UyAXXhuaYcS4zpjQKgX01zzQ7dKpBx4rfuI+Ol2CL60NG/5IYRTcoLz9HL61
         Mn94DGp6mhK3Bcv6MppWiocpY7/JlMmiuxXkNUNDF3bRbBnn4WZP9RuZ0UVNvTCnizI7
         1GUR4YPnpSPD64NohbKU98eJixVD4AjqRNLdiMwRhxWDx7c3WEl7XkSSWlQxdKzGCpzJ
         MClRDIemKZlUpC+RdRAJbSly++Mla3XZ3yG+3aGOBUkoH5QuW9nPhlKhHWF2sKscsbbl
         Z6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627171; x=1794231971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iIKunQE+SicAhyjZQ/MMzEjIQWaAEW2rMinTZr7v7uI=;
        b=YU3sroamZkl9ZvmLLpqbcfnzTOvP4q59O/MzZcZJzMejOKeNVJmG264X8K+qCFf14x
         IEHdRCsUP5tQmH2WM0UOTkl64eNhwGycVfVTecCSowvcbK+7BcXf3qF+eLCgAtVPMxPg
         aYfVTmqWHDWY0Rc/8R6lahmY8eWHZVe8oujZGPNT8b1hYHYa/FxD4CMnAaUjIoaA+t20
         iU6CQWdd4JuwnjkexhymiYMaOggKGS5tikvwatD+gP2Lx1fwmpWSXLeR4XjvXJSExSXs
         WmUb+I3l5jdDmNowqK4cXoQoG4+riQJOfRFHp8sTJ/oYT3+N9rrExE+TKQgplsK0lq6m
         munw==
X-Forwarded-Encrypted: i=1; AKwUvBxRIcqEqLBuZO8g92oLONGP1rbjiw5Nh6tH/NbNXqldlabD98qdy1ICuNOkS4PU0ESksmP1bTDh7SVR1LliaQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLaJn5xT7XTql0TdAPLDoYLIgZCO7PXjykm2Xr5LzJlU+4ChMkm
	0Zjjbou11oU/64sAnOcTf/igbQAfZCP0IuommsWivO5ERj4NCd5E8Q6I
X-Gm-Gg: AYBFou3bo0e/2wQNvLkaKcPgSpUCAG0j6/RWGqpWr35OSUtp1Dbal6Jvvn2TFWIUMAt
	QM+nrRmLPOPlJt1/Rzfr6amf6viyM+eR4Bva039xOgdANF6XIH0xGP5qYaROa6J02BNCLFIChFF
	5VJyRuSqhY1VFDRSA/GpeehXuq2MZAbxKEpqG3UyZNL3afDA0/bb2YnGkNo4l8q+Mw7zwpWGQrS
	n7yHBYEpOVLU8OnTTvhj457w4/E7jkunPFrDXJ5Gd5N/tWyBaNN6GSXoeWRbSQzj8VRn2i4eEaD
	CHMYekSWuXPq6quGBGT5v8fIQThv7lHb2EGogNe+tcBgFlClC8CVHk+tmzVZhgONddUU3FP6L62
	hDdHuaI+fOyj+j9Pxk5bwu3WJ3EfasZef4Wc/tp8bqOtTBVGxOrVad7dFJp2kKJ5irtzdXfHXnS
	vXUFlMyfOqa+3ltJGmTaxCiW/BWaXGGbgQzggoQ2ttWM44cIxjLnSWgMOy0NcBNC7BQv5UYRwvL
	Lp5DXHEJgGi6TsJQ3hOQq3pq646FBwYjLjPqPR1LedhWtkNOhnkytGd3ouykjKbeDADmrvg34St
	J40nBaCRa3c9Adzs89FA7K/OAeF05a+3MH3RkIk/KPEgVqxwASNRn/SafEdsxyCcsxjOtPaBmsv
	EDrqnAPk8Z3LGSHNI8fME
X-Received: by 2002:a05:600c:848c:b0:4a1:f99e:f22d with SMTP id 5b1f17b1804b1-4ac17471091mr245581665e9.6.1793627170881;
        Mon, 02 Nov 2026 05:46:10 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09cc3e9asm120156185e9.3.2026.11.02.05.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:46:10 -0800 (PST)
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
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Hui Su <sh_def@163.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched: Fix cpuset_mutex double unlock in __sched_setscheduler()
Date: Mon,  2 Nov 2026 14:46:05 +0100
Message-ID: <20261102134606.242743-1-parri.andrea@gmail.com>
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

A sched_setattr() with SCHED_FLAG_KEEP_POLICY on a SCHED_DEADLINE task
unlocks cpuset_mutex twice if the task's policy changes concurrently:

  WARNING: bad unlock balance detected!
  7.4.0-rc1 #1 Not tainted
  -------------------------------------
  repro/126 is trying to release lock (cpuset_mutex) at:
  [<ffffffff9a17cacc>] __sched_setscheduler+0x9cc/0xc40
  but there are no more locks to release!
  ...
  Call Trace:
   print_unlock_imbalance_bug.part.0+0xfb/0x110
   lock_release+0x286/0x2e0
   __mutex_unlock_slowpath+0x1a/0x400
   __sched_setscheduler+0x9cc/0xc40
   __x64_sys_sched_setattr+0xa3/0x1b0
   do_syscall_64+0x106/0x5f0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

__sched_setscheduler() samples p->policy before taking any lock, and
restarts from the recheck label if p->policy differs under the rq lock.
The restart drops cpuset_mutex but leaves cpuset_locked set, so a pass
that no longer needs the mutex still unlocks it on its way out:

  CPU 1                                CPU 2
  __sched_setscheduler(KEEP_POLICY)
    policy = p->policy /* DEADLINE */
                                       __sched_setscheduler(SCHED_OTHER)
                                         p->policy = SCHED_OTHER
    cpuset_locked = true
    cpuset_lock()
    rq = task_rq_lock(p)
    oldpolicy != p->policy
      cpuset_unlock()
      goto recheck
    /* no cpuset_lock() this time */
    ...
    if (cpuset_locked)
      cpuset_unlock()

Without CONFIG_DEBUG_MUTEXES, or CONFIG_DEBUG_RT_MUTEXES on PREEMPT_RT,
nothing warns. The second unlock still clears the owner field regardless
of who holds the mutex, so another task can lose cpuset_mutex inside its
critical section. Entering SCHED_DEADLINE needs CAP_SYS_NICE, but a
racing caller that owns the task does not need it if it samples a policy
other than SCHED_DEADLINE.

Clear cpuset_locked when dropping the mutex for the restart. This should be
safe because the flag is only tested on the paths leaving the next pass,
after that pass has set it again if it took the mutex.

The following program, run as root, reproduces the splat, which no longer
appears with this applied. On PREEMPT_RT it crashes the kernel within
seconds, which this also fixes:

  #define _GNU_SOURCE
  #include <pthread.h>
  #include <stdint.h>
  #include <sys/syscall.h>
  #include <unistd.h>

  struct attr {
      uint32_t size, policy;
      uint64_t flags;
      int32_t nice;
      uint32_t prio;
      uint64_t runtime, deadline, period;
  };

  static volatile int stop;
  static volatile pid_t target;

  static void set(struct attr a)
  {
      a.size = sizeof(a);
      syscall(SYS_sched_setattr, target, &a, 0);
  }

  static void *sleeper(void *arg)
  {
      target = syscall(SYS_gettid);
      while (!stop)
          usleep(1000);
      return arg;
  }

  static void *switcher(void *arg)
  {
      while (!stop) {
          /* SCHED_DEADLINE, 2us every 1s */
          set((struct attr){ .policy = 6, .runtime = 2000,
                             .deadline = 1000000000,
                             .period = 1000000000 });
          set((struct attr){ .policy = 0 }); /* SCHED_OTHER */
      }
      return arg;
  }

  static void *racer(void *arg)
  {
      /* KEEP_POLICY | KEEP_PARAMS */
      while (!stop)
          set((struct attr){ .flags = 0x18 });
      return arg;
  }

  int main(void)
  {
      pthread_t t[5];
      int i;

      pthread_create(&t[0], NULL, sleeper, NULL);
      while (!target)
          usleep(100);
      pthread_create(&t[1], NULL, switcher, NULL);
      for (i = 2; i < 5; i++)
          pthread_create(&t[i], NULL, racer, NULL);
      sleep(30);
      stop = 1;
      for (i = 0; i < 5; i++)
          pthread_join(t[i], NULL);
      return 0;
  }

An LLM helped find the PREEMPT_RT crash and write this patch and its test.

Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20261016062629.2102883-1-sh_def%40163.com
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Cc: stable@vger.kernel.org
---
Sashiko reported this while reviewing [1], which adds another exit from
the second pass. The bug does not depend on that patch.

Tested on x86_64 with lockdep and DEBUG_MUTEXES: the splat fires without
this patch and not with it.

Also tested on PREEMPT_RT with lockdep, with DEBUG_RT_MUTEXES only and with
neither: each kernel oopses within seconds without this patch, and runs
clean for 30 seconds with it.

The 2us reservation only keeps the test running: tasks leaving
SCHED_DEADLINE while asleep leak total_bw [2], so a 1ms/10ms reservation
stops being admitted after 38 switches on 4 CPUs, and 2us after about 2
million.

[1] https://lore.kernel.org/20261016062629.2102883-1-sh_def@163.com/
[2] https://lore.kernel.org/2b5fb3f22bca6aa383be8f4781923392@kernel.org/

 kernel/sched/syscalls.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 45a127deeadd9..2af550f92ac65 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -640,8 +640,10 @@ int __sched_setscheduler(struct task_struct *p,
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
-		if (cpuset_locked)
+		if (cpuset_locked) {
 			cpuset_unlock();
+			cpuset_locked = false;
+		}
 		goto recheck;
 	}
 
-- 
2.53.0

