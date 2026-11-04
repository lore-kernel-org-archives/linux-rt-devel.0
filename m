Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826738;
	b=bkcOLzpfXSdCA9Wlq3H2wiLG4RAzybElJwyYx8/xfEREKy9rc3IDa0vE+T2Xy9N6Rloc
	 Iv9Y9+bhTRdnx+ch0L/D00cUEjAuoXTpzNb/t8lTIQ6a6jLxOyKah0R66erNbjABvabMS
	 FPHV5aDjoBxzCJDGe8ToWuRgwmC5PQExYCxQYvNUpySyK/q2hDYR8DW+iRYH+Gk9Aqj8p
	 HGyNH9OraAvetMBUAYUNESmYls5GuTpwQFSZpSSjrRjlgibrJwVDr2Wx1sFxtcavqYzDP
	 ExX9xgWqhC2031BmV0WyhpjgLGwZtb0972kLSbnBWvk82atM5RFH1QVEu4y1ZWuE50Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826738;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ChLFQWCk652mUP4S/O+9t2QlE7hbeEo2w82TCfEo8Cw=;
	b=04tKMjjX2jTatWOd6kuFWc1OXrAiKr8Claiswty9NZSBd44mXiodhL7Tb/VOKZOAIJG6
	 bX0IcRjTqzWUI0LSJ/I7mHuoCEBCYNJ3o1lCIur9/MttsMplZ9QJ4vwWAqiN8mbUL672k
	 lbuxN+CzVdt1qSwth6QbFUCPAE+8fZ7tIGXse67MGPom1liXzJy+EATqhwbhIl69pogD9
	 Qs1qjPoM2kvyhXkgEZsL6KFc/FPDtRQZCCYsjK2k36MfS3tUiKFyecPY348q8oDNnPu8+
	 /YgSiBr0P1wQQDqy7wrCReawO/NVbBIUko26mNHOUYQVipSjMtU9S6NwbNiTgQ6AByg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=kNnbAoqV;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41C60A2603
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 21:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F41C60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=kNnbAoqV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793826735;
	bh=ChLFQWCk652mUP4S/O+9t2QlE7hbeEo2w82TCfEo8Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNnbAoqVJRfhwyLCy/mgEQlqHjfNelnGmaNt/SJYgFU63KczzwWOXhFn4pe4YDr21
	 0RT/kL2GfShVWshEKcaJve8+5ixmbIuKji03XlMiBLKVHv39G4mZ2yddqqPlIGbGJp
	 YnpugQFC2yZxA1ZA2WHbOI/BMSEK52ExpVC1vyeHI+bjFaKk54v0vf9G2C016YAHX5
	 XW+cjXys/WNYBO5zo1vke3Vf6xNoyy/fHYzWgLesuDjzfB54LMuxZ9+LXl7XNTePwH
	 /KP6ZmwyQ2kJvsj+yFL8gISIMIeUUDNyr8PcdkiJDjWK4giyhb4qqDsuoXQ3GPRikR
	 4il27nGwvQ9wg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jKdRz5twZzKy6;
	Wed, 04 Nov 2026 16:12:15 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v2 20/21] sched/deadline: Cancel the replenishment timer with the parameters
Date: Wed,  4 Nov 2026 16:12:06 -0500
Message-Id: <20261104211207.1392343-21-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
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

The replenishment timer of a throttled task is armed for its next
period, which can come after its 0-lag time: a task that yielded keeps
runtime, and a constrained-deadline task that overruns by little
reaches its 0-lag time within the same period. Leaving SCHED_DEADLINE,
such a task has its parameters cleared at the 0-lag time with that
timer still armed.

Back in the class before it fires, the task throttles again, and
start_dl_timer() leaves the armed timer where it is:

	if (!hrtimer_is_queued(timer)) {
		if (!dl_server(dl_se))
			get_task_struct(dl_task_of(dl_se));
		hrtimer_start(timer, act, HRTIMER_MODE_ABS_HARD);
	}

so the replenishment comes at the period of the reservation the task
left: too early, which hands it runtime it has not earned, or up to a
period too late.

Commit a649f237db18 ("sched,dl: Fix sched class hopping CBS hole") left
that timer armed on purpose, as what reset a task that stayed out of
the class. The 0-lag time took that over and left the timer behind:
cancel it where the parameters go.

Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/deadline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c0af06d0f368..15d224846eba 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -563,6 +563,7 @@ static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_task)
 				if (READ_ONCE(p->__state) == TASK_DEAD)
 					sub_rq_bw(dl_se, &rq->dl);
 				dl_task_release_bw(p);
+				cancel_replenish_timer(dl_se);
 				__dl_clear_params(dl_se);
 			}
 		}
@@ -2326,6 +2327,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		}
 
 		dl_task_release_bw(p);
+		cancel_replenish_timer(dl_se);
 		__dl_clear_params(dl_se);
 
 		goto unlock;
-- 
2.47.3

