Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC33A6F15;
	Wed, 13 May 2026 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701155; cv=none; b=ErB0IMpEwD0jvfYHHipZ8ZzJvLm13M1I9zziw/rykuCG7DXlDfLpv3Wp8FFpYoRN+QoKvwzE9NE5XY7ZUrk1DLB45YrsNXWo2dzafBBkd2I0qucZUIp9QfvrvIQ+V9iosS7lsS6McxiIlu06nSyBdQb80jxW6v5ugXxgbTerfgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701155; c=relaxed/simple;
	bh=bZh8ajTH/FHxGTNxvIEWwd6OX3IPyj4iu4FOoERxskg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcxMQyr6d0sJttAx6bbNe/sqjXkYbwv5O2bNzLcZc0QKSpn1dOsZlThkJuYeeYovsIPanNMR1IZMEmoLTIIZPihKGNUt/ACYYNWkjunjgF+6Ck7kWQUmQ7rcxdKfhoXrAHO8dT30Y9CTXwxXivSZkVllaXZKXpcYFTTy2RwwDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilkVdvR4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilkVdvR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E434C2BCB7;
	Wed, 13 May 2026 19:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778701155;
	bh=bZh8ajTH/FHxGTNxvIEWwd6OX3IPyj4iu4FOoERxskg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilkVdvR4g6fxP/acHHEDFSNiPxqkgjfXau0TgrXSPrWxHGm/TXD84deKhu/Tg/NJf
	 AK/rcMT22hOq0DF0oeiZZwx7M3j+rxK7lDyu4ho0H2awSI2ywsAbJzH5a4+r0hSoNe
	 SAl5QyvJ8QqGvdMBclSQpH0dsj9hslxZG/0C2w+bE6TRE1J4QQDw4lNbAUFvb8W9sq
	 ch9GPiFftgcSrVkS9yEQ1od2SuAhI6beKhf2/GTs5g6dkxgCCeES7XJ3rXP3ZaskGh
	 wLSmODjP9AMi9tyNF8b2dWcUnBbrP+8ocLvQpxUJShxWK71eWQ5Xb+TPvBxs/iC86C
	 rYpHGGTh5xYRw==
From: Tejun Heo <tj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tejun Heo <tj@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kyle McMartin <jkkm@meta.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Linux RT Development <linux-rt-devel@lists.linux.dev>,
	Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Date: Wed, 13 May 2026 09:39:14 -1000
Message-ID: <20260513193914.1593369-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512172847.5024e5e8@gandalf.local.home>
References: <20260506235716.2530720-1-tj@kernel.org> <20260507141437.GJ3102624@noisy.programming.kicks-ass.net> <20260512113754.448c1f5b@gandalf.local.home> <056f95bc5805f7e161458984fff4b3cb@kernel.org> <20260512172847.5024e5e8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Capturing this on the actual production hosts is awkward. It requires
a fleet with a particular management operation in flight, and while
the aggregate occurrence rate is reliable, which specific machine
hits it isn't predictable, so I haven't been able to catch one with
tracing on.

Production context: hosts serve live network traffic and storage IO.
CPU util before lockup is moderate (~30-40% steady state), but the
moment-to-moment softirq work is bursty - traffic patterns, IO
completions, plus the PSI poll triggers that source the migratable
psimon. Once softirq processing falls behind on a CPU, work piles
up. With the prio-bail-without-clearing-overload path, the IPI
storm forms on top and amplifies the slowdown.

So, here's a capture from a synthetic reproducer that I think
models the dynamic and reaches the same end state.

Test box, 192 CPUs, kernel without the fix:

- Per-target hrtimer (HRTIMER_MODE_REL_PINNED_HARD) fires every
  750us. Each fire schedules one tasklet round-robin from a pool
  of 20k distinct tasklets. Each tasklet body is a 500us cpu_relax
  loop, standing in for "process one item of softirq work".

- Storm driver: 190 SCHED_FIFO-50 nanosleep loops on non-target
  CPUs drive tell_cpu_to_push from balance_rt. Two synthetic
  psimon-shaped kthreads (FIFO 1) bound to the targets to pin
  them into rto_mask.

Baseline (no storm helpers): ~85% softirq util, no lockup, runs
indefinitely. The reproducer's baseline is higher than production -
my guess is we need to scrape up against capacity to grow a backlog
with the fixed-shape workload here, while production gets the same
effect from bursty arrivals during brief slowdowns.

With the storm: walker IPI overhead stretches each tasklet body
from 500us to ~1.1ms. Service rate drops below arrival, backlog
grows ~430/s. After ~46s, one tasklet_action_common snapshot has
~20k tasklets which it processes serially in BH-disabled softirq
context. That's ~22s uninterruptible, watchdog fires.

Six soft-lockups in a 120s run:

  [61125.38] BUG: soft lockup - CPU#95 stuck for 22s! [kworker/95:0]
  [61145.38] BUG: soft lockup - CPU#47 stuck for 45s! [migration/47]
  [61173.38] BUG: soft lockup - CPU#47 stuck for 71s! [migration/47]
  [61197.38] BUG: soft lockup - CPU#95 stuck for 22s! [migration/95]
  [61209.38] BUG: soft lockup - CPU#47 stuck for 21s! [kworker/47:1]
  [61225.38] BUG: soft lockup - CPU#95 stuck for 48s! [migration/95]

Stack at fire:

  rt_storm_wedge_fn+0x22/0xe0
  tasklet_action_common+0x100/0x2b0
  handle_softirqs+0xbe/0x280
  __irq_exit_rcu+0x47/0x100
  sysvec_apic_timer_interrupt+0x3a/0x80     <- watchdog hrtimer
  asm_sysvec_apic_timer_interrupt+0x16/0x20
  RIP: 0033:0x...     <- user task (rt_storm_hog)

Trace captured with your event list plus IPI:

  -e sched_switch -e sched_waking -e irq -e workqueue -e ipi
  -e irq_vectors:call_function_single_entry/exit
  -e irq_vectors:irq_work_entry/exit
  -e irq_vectors:reschedule_entry/exit
  -e irq_vectors:local_timer_entry/exit

Sliced to a 17s window around the first RCU stall + first
soft-lockup, filtered to CPUs 47 and 95, gzipped text (~11MB):

  https://drive.google.com/file/d/11AN6dyvOWiZLVNEEuVtQieRyAxJYbCbt/view?usp=sharing

Thanks.

--
tejun
