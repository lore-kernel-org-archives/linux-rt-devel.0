Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E552417D9
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 May 2026 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154080; cv=none; b=mZIXVATgp0stPmEQ2UiNJInW3Phf7lFCv51xBtlxDHGcdzHwilYmTiaoS5EG56skF3yJuDf+DvMelEDwQNP4YzE0QGO1yjh1PzJsViv8GST5e1vw4mAkco29oEHIrsyUj8OMWZcbiW7W2RlIphfq2UKzZyb1DNcCV5ijhgQqHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154080; c=relaxed/simple;
	bh=R2CXmKtrbnfFFYRwuiAv0qD3pZe3w4XoySXfZFi3yow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0zSEsSZb0q1cYMpJ7SjuqwNejYtSlgBTa2HlO62GwG6/XYocJg+84KU5uJQ8MQOqhaVu67e+9TzCicd/nSQv7hc6++9jYNKmJiAAUU4SE3OuCoQK9eYdB9eCE39tcitEu72Pu+hJnM4VRVjif7KaeAGu9/pLLIWQIBC5Fntsc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE3q4JEt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE3q4JEt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso20910615e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 18 May 2026 18:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779154077; x=1779758877; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TWeQWtJQMxeeRXnY89NFG6LDLskX6Fx4PPSnkyRbsAw=;
        b=fE3q4JEtdeGbCnm/3WJS7SE/PdqdJwGIGkh/4OxOZjNtezoB7pLZeDBnJdQhDvmACE
         re4LPwFMiDRFAgp5vxRdouj5ig5wb+ofYCQDMVejX0fFrT07y3A6gzN23D3tr5WMKfEh
         HD84J5U8cXyXtzjehdRdNCZTME4XAXBCQzIzzEZ6BHlHxvF9Ln6ZStLlBCCU0x661JbT
         kkNtAodPN5Xmsnl5Kp7mObeZsxL5+dwXGLduyVm0QmPiUIuSaKR+IbUk58mYZxH0jeM7
         pV5s0HyN2oGYLvLK6YrEqcRl2PRf8XuaDQR/SSEMXxv91auR3kGhiY8ps4OgEDMss3Zm
         a9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154077; x=1779758877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWeQWtJQMxeeRXnY89NFG6LDLskX6Fx4PPSnkyRbsAw=;
        b=DjFSb9/AAt91mtRg+5h6BZddovrryMcFd+zO7e1GgWoBDPa84dJlAP439xpMRTpTGo
         Ret3c5vMresLK1lBgCJfIBfFlhfA3qByWKFsOnoAlJPhiS7UJc00OxaZBmeYnNOe1tL7
         ngb7mEImgp7uN3C/khlQJhen1vlsIJh0p5qCcrlBYa9oQWHknUqLN1LRPkeHQvDAB8Fq
         NhwFnwFd73ZbDTlHicQ1YLQSJqG6wKarapYqm7MLn7Ov3RRgvYd9lGQMzNI3RlqH7m22
         HdqghbzdK+P1PBBpdLaB6Y0kQyXIxM+pct92fTksc6wiGU7jzKFrJybkoGqVYEd70QEh
         KQFw==
X-Forwarded-Encrypted: i=1; AFNElJ9FDAB9KSfb1cOziqIPvzaAzP9IxUXVo3qvNk8i0usLOv08OPKoKY2fZYT9SCXWeWyUAV3I6aiKSW92YfQuUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8tfdhs+00EqCdidPUcKOdKFt3QCtAfaY/dLR0s1J3sXj6aqPo
	eccqgFCTuwB3KNKBtZ6CR86V04Jf8ys7C5LiY13ul4J68bFAGmUi0mY6cLwKVVxq
X-Gm-Gg: Acq92OEFfNhpdJukPgZqP9wsaSMZWBlgsrp+aLDDjxnBOhsFY0iE43PeLDmi2az1fyU
	LCP0RQ/gfz/cTcLphiLDC172o7Jsa+QSixgokVSid6sulB99YbMR/Ipi7iVYzx0eHNuS7fW2GsA
	X+KsPNkPxqDVH+WjkSv6Jkw1+hLN8Nijh6mSTrcXEkpoMGJJINLGk4RedDI5NAeqsTB7kzMyeMW
	8nuO1LnQHBXFf6sXip/ZnSTI+aU0yhIye5Pycz8F4JsNVr2Ft3+ENH2cEhERKOupxqkgjklY/5Q
	7HWfnQ1JO48YxG8nLlzIjrNt3uWzb4VEjp40tcr24IQKi4y1bzrPJ7KI93tUhYvzkj5fve+3TJ7
	sXEoIetelQOEwB1P4n0i6FQQqB9EBCCZJL6qHedJP4QA4w9+tvTtqUtKNFqeh09e17wA71t/WAl
	lesZ4YgV/8jJ3eeMlArSCi0Q78uzXFHUNpDBzdSi6F
X-Received: by 2002:a05:600c:1d0d:b0:48f:da34:ec4e with SMTP id 5b1f17b1804b1-48fe632343dmr250425635e9.19.1779154076414;
        Mon, 18 May 2026 18:27:56 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f83:8501:800:cd4:5e2:9556])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm40548683f8f.16.2026.05.18.18.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:27:56 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Leonardo Bras <leobras.c@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>,
	Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Coiby Xu <coxu@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v4 0/4] Introduce Per-CPU Work helpers (was QPW)
Date: Mon, 18 May 2026 22:27:46 -0300
Message-ID: <20260519012754.240804-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9299; i=leobras.c@gmail.com; h=from:subject; bh=R2CXmKtrbnfFFYRwuiAv0qD3pZe3w4XoySXfZFi3yow=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLK494QflH1w7EaT7zmFI0+eT+DY+qaHmdulKf3ETu8UO 0mVSjH+jlIWBjEuBlkxRRbZR/NX8XyfknHkyo8FMHNYmUCGMHBxCsBE9oYzMlzmXGXIxl1sICwS V/dYPflDnvoXz8DbbLzKS6/dfhug4cLIcG3Zk327Kidn/WZgcMmNk3q/aJG5yrszGxu3Lsue7P3 4NAsA
X-Developer-Key: i=leobras.c@gmail.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

The problem:
Some places in the kernel implement a parallel programming strategy
consisting on local_locks() for most of the work, and some rare remote
operations are scheduled on target cpu. This keeps cache bouncing low since
cacheline tends to be mostly local, and avoids the cost of locks in non-RT
kernels, even though the very few remote operations will be expensive due
to scheduling overhead.

On the other hand, for RT workloads this can represent a problem: getting
an important workload scheduled out to deal with remote requests is
sure to introduce unexpected deadline misses.

The idea:
Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
In this case, instead of scheduling work on a remote cpu, it should
be safe to grab that remote cpu's per-cpu spinlock and run the required
work locally. That major cost, which is un/locking in every local function,
already happens in PREEMPT_RT.

Also, there is no need to worry about extra cache bouncing:
The cacheline invalidation already happens due to schedule_work_on().

This will avoid schedule_work_on(), and thus avoid scheduling-out an
RT workload.

Proposed solution:
A new interface called PerCPU Work (PW), which should replace
Work Queue in the above mentioned use case.

If CONFIG_PWLOCKS=n this interfaces just wraps the current
local_locks + WorkQueue behavior, so no expected change in runtime.

If CONFIG_PWLOCKS=y, and kernel boot option pwlocks=1,
pw_queue_on(cpu,...) will lock that cpu's per-cpu structure
and perform work on it locally. 

v3->v4:
- Mechanism name changed from QPW to PW/PWLOCKS. Helper funcions / API,
  file names and config options renamed accordingly.
- All members of the Per-CPU Work API now start with the same prefix 
  (Frederic Weisbecker)
- Improved style a bit, reviewed documentation

v2->v3:
- Use preempt_disable/preempt_enable on !CONFIG_PREEMPT_RT (Vlastimil Babka).
- Improve documentation to include local_qpw_lock on operations table
  (Leonardo Bras).
- Enable qpw=1 automatically if CPU isolation is enabled (Vlastimil Babka).

v1->v2:
- Introduce local_qpw_lock and unlock functions, move preempt_disable/
  preempt_enable to it (Leonardo Bras). This reduces performance
  overhead of the patch.
- Documentation and changelog typo fixes (Leonardo Bras).
- Fix places where preempt_disable/preempt_enable was not being
  correctly performed.
- Add performance measurements.

RFC->v1:

- Introduce CONFIG_QPW and qpw= kernel boot option to enable
  remote spinlocking and execution even on !CONFIG_PREEMPT_RT
  kernels (Leonardo Bras).
- Move buffer_head draining to separate workqueue (Marcelo Tosatti).
- Convert mlock per-CPU page lists to QPW (Marcelo Tosatti).
- Drop memcontrol convertion (as isolated CPUs are not targets
  of queue_work_on anymore).
- Rebase SLUB against Vlastimil's slab/next.
- Add basic document for QPW (Waiman Long).

The performance numbers, as measured by the following test program,
are as follows (v3, mechanics not changed since then):

CONFIG_PREEMPT_DYNAMIC=y
Unpatched kernel:                       60 cycles
Patched kernel, CONFIG_QPW=n:           62 cycles
Patched kernel, CONFIG_QPW=y, qpw=0:    62 cycles
Patched kernel, CONFIG_QPW=y, qpw=1:    75 cycles

CONFIG_PREEMPT_RT:
Unpatched kernel:                       95 cycles
Patched kernel, CONFIG_QPW=y, qpw=0:    99 cycles
Patched kernel, CONFIG_QPW=y, qpw=1:    97 cycles

kmalloc_bench.c:
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/timex.h>
#include <linux/preempt.h>
#include <linux/irqflags.h>
#include <linux/vmalloc.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Gemini AI");
MODULE_DESCRIPTION("A simple kmalloc performance benchmark");

static int size = 64; // Default allocation size in bytes
module_param(size, int, 0644);

static int iterations = 9000000; // Default number of iterations
module_param(iterations, int, 0644);

static int __init kmalloc_bench_init(void) {
    void **ptrs;
    cycles_t start, end;
    uint64_t total_cycles;
    int i;
    pr_info("kmalloc_bench: Starting test (size=%d, iterations=%d)\n", size, iterations);

    // Allocate an array to store pointers to avoid immediate kfree-reuse optimization
    ptrs = vmalloc(sizeof(void *) * iterations);
    if (!ptrs) {
        pr_err("kmalloc_bench: Failed to allocate pointer array\n");
        return -ENOMEM;
    }

    preempt_disable();
    start = get_cycles();

    for (i = 0; i < iterations; i++) {
        ptrs[i] = kmalloc(size, GFP_ATOMIC);
    }

    end = get_cycles();

    total_cycles = end - start;
    preempt_enable();

    pr_info("kmalloc_bench: Total cycles for %d allocs: %llu\n", iterations, total_cycles);
    pr_info("kmalloc_bench: Avg cycles per kmalloc: %llu\n", total_cycles / iterations);

    // Cleanup
    for (i = 0; i < iterations; i++) {
        kfree(ptrs[i]);
    }
    vfree(ptrs);

    return 0;
}

static void __exit kmalloc_bench_exit(void) {
    pr_info("kmalloc_bench: Module unloaded\n");
}

module_init(kmalloc_bench_init);
module_exit(kmalloc_bench_exit);

The following testcase triggers lru_add_drain_all on an isolated CPU
(that does sys_write to a file before entering its realtime
loop).

/*
 * Simulates a low latency loop program that is interrupted
 * due to lru_add_drain_all. To trigger lru_add_drain_all, run:
 *
 * blockdev --flushbufs /dev/sdX
 *
 */
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <stdarg.h>
#include <pthread.h>
#include <sched.h>
#include <unistd.h>

int cpu;

static void *run(void *arg)
{
        pthread_t current_thread;
        cpu_set_t cpuset;
        int ret, nrloops;
        struct sched_param sched_p;
        pid_t pid;
        int fd;
        char buf[] = "xxxxxxxxxxx";

        CPU_ZERO(&cpuset);
        CPU_SET(cpu, &cpuset);

        current_thread = pthread_self();   
        ret = pthread_setaffinity_np(current_thread, sizeof(cpu_set_t), &cpuset);
        if (ret) {
                perror("pthread_setaffinity_np failed\n");
                exit(0);
        }

        memset(&sched_p, 0, sizeof(struct sched_param));
        sched_p.sched_priority = 1;
        pid = gettid();
        ret = sched_setscheduler(pid, SCHED_FIFO, &sched_p);
        if (ret) {
                perror("sched_setscheduler");
                exit(0);
        }

        fd = open("/tmp/tmpfile", O_RDWR|O_CREAT|O_TRUNC);
        if (fd == -1) {
                perror("open");
                exit(0);
        }

        ret = write(fd, buf, sizeof(buf));
        if (ret == -1) {
                perror("write");
                exit(0);
        }

        do {
                nrloops = nrloops+2;
                nrloops--;
        } while (1);
}

int main(int argc, char *argv[])
{
        int fd, ret;
        pthread_t thread;
        long val;
        char *endptr, *str;
        struct sched_param sched_p;
        pid_t pid;

        if (argc != 2) {
                printf("usage: %s cpu-nr\n", argv[0]);
                printf("where CPU number is the CPU to pin thread to\n");
                exit(0);
        }
        str = argv[1];
        cpu = strtol(str, &endptr, 10);
        if (cpu < 0) {
                printf("strtol returns %d\n", cpu);
                exit(0);
        }
        printf("cpunr=%d\n", cpu);

        memset(&sched_p, 0, sizeof(struct sched_param));
        sched_p.sched_priority = 1;
        pid = getpid();
        ret = sched_setscheduler(pid, SCHED_FIFO, &sched_p);
        if (ret) {
                perror("sched_setscheduler");
                exit(0);
        }

        pthread_create(&thread, NULL, run, NULL);

        sleep(5000);

        pthread_join(thread, NULL);
}

Leonardo Bras (3):
  Introducing pw_lock() and per-cpu queue & flush work
  swap: apply new pw_queue_on() interface
  slub: apply new pw_queue_on() interface

Marcelo Tosatti (1):
  mm/swap: move bh draining into a separate workqueue

 MAINTAINERS                                   |   7 +
 .../admin-guide/kernel-parameters.txt         |  10 +
 Documentation/locking/pwlocks.rst             |  76 +++++
 init/Kconfig                                  |  35 +++
 kernel/Makefile                               |   2 +
 include/linux/pwlocks.h                       | 265 ++++++++++++++++++
 mm/internal.h                                 |   4 +-
 kernel/pwlocks.c                              |  47 ++++
 mm/mlock.c                                    |  51 +++-
 mm/page_alloc.c                               |   2 +-
 mm/slub.c                                     | 142 +++++-----
 mm/swap.c                                     | 109 ++++---
 12 files changed, 624 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/locking/pwlocks.rst
 create mode 100644 include/linux/pwlocks.h
 create mode 100644 kernel/pwlocks.c


base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.54.0
