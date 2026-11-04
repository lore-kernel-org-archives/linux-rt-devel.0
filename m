Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826734;
	b=M3b2VC9Nfg8jzR7E7hCOzFqoVNyd5fRTR76AZ+bLS3f7IJ3oLXND4KY016u5Przv+Z6n
	 j8/DKggAO6kIrs2M/ae9cEEgKiT4Vgk2nTD8cQWzjGvz9xCTqrwlwxUlY5o/JJl8V79+5
	 cOzJqSg8/HRJlVwD9ZAh9knPxzB2l+nkHGtzCR4l0NYtWYcJ9dCYt+2cGNR2jdupZQA9u
	 NYZ2tIHTzEqGXKcltPzX4KxP10kf/GX6kUHtQCGBKHdwCHOCF1hj+XYK3ensUWxJuiw4+
	 0HTzb6fT6wKFanCNt0swSPrEesarnk7JOq7qBHIqfP8KoTXkRN1Pn2iL32g9LkUwHoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826734;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UsrKnvwlQYb35Cn4Xi/osXwC+gd2FU0rAvjvRwmMxzY=;
	b=W8VQBC8BdR/b5HurDDwwkcQXRvqMCWEt0KLlxh3oDzqRaPnXd9o57REPYO1eMK08Y1io
	 u14cb3n/ih9Qr4GznLrlzZuzq2zcvdqswXiNS7/6N87tDz3n1d6JUGAU6Dq6jjDL0ztY7
	 op/+y6hjPtlA9rrCP8ycKzGt7Uk5+OzpPcxDB+NkWC7If5p+LhTys0urktHD0yliSZdD8
	 XQDD87MDk2gyRtvUh5NmlpwupsdognekTm7TsuSbPLS0wCjQXbzXjOSdTOcAPwdXygOPI
	 vZNbQRnoJ72sL4V4TWLKhQz9jwv4vZx6e+A2hE1NVH7fsXZTZ67lEtu6QmTpst61fiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=bSYV0MMY;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E1606D81F
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 21:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D25E1606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=bSYV0MMY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793826733;
	bh=UsrKnvwlQYb35Cn4Xi/osXwC+gd2FU0rAvjvRwmMxzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSYV0MMY2XyNxcGi7+oI+fWvvZzI+S6sys2TX1D9/LxSXGf+np5qkfDKyNBZZwnsb
	 UXN3nod/Umyzuv5HWa9i468Bb+d49P5HaOfgUBNu6n9v5eTR/CAfyT4g4OONAMgKbk
	 zwFZaxHmHDngnmbCU7YmJ2n7Rkr58xKKgA7xiUDCjTKfoAMVTMh0liTDT7ziX80kBA
	 1qHZW5Ynu21c0XVni7uom2Z6oGJ5GncX+mDa0471khY8uDP2loMP+vwYs6MKp0KwG6
	 G3h9bfNr+uSAkpFmw7CQgE7abNYnqStPJiF7mqHg5eMm37csD31royogbTRjnnRB3Z
	 +D5j8ao59t3Bw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jKdRw6yngzKqY;
	Wed, 04 Nov 2026 16:12:12 -0500 (EST)
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
Subject: [PATCH v2 03/21] sched/deadline: Do not admit bandwidth for parameters that are kept
Date: Wed,  4 Nov 2026 16:11:49 -0500
Message-Id: <20261104211207.1392343-4-mathieu.desnoyers@efficios.com>
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

sys_sched_setattr() fills a SCHED_FLAG_KEEP_PARAMS request in from the
task itself (get_params()), with no lock held, and
__sched_setscheduler() then skips __setscheduler_params(): the task
keeps the parameters it has, and its dl_bw with them.
sched_dl_overflow() runs all the same.

A parameter change of the task's own that lands in between leaves the
request stale, and dl_param_changed() takes it for a change: total_bw of
the root domain, and this_bw and running_bw of its runqueue through
dl_change_utilization(), then hold a bandwidth the task does not have,
and the release at its 0-lag time, which takes the task's own dl_bw,
leaves the difference behind.

There is nothing to admit for parameters that are kept: skip the check.

Found by reading, after the Sashiko AI review of the first posting of
this series raised the case the previous patch refuses. Not reproduced:
it needs a parameter change of a deadline task to land inside the window
of a SCHED_FLAG_KEEP_PARAMS request on the same task.

Fixes: a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/syscalls.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ab0a573e9b37..8eddb9d47d8e 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -698,8 +698,14 @@ int __sched_setscheduler(struct task_struct *p,
 	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
 	 * is available. Last of the checks: nothing gives back the
 	 * bandwidth it reserves.
+	 *
+	 * Nothing to admit for parameters that are kept
+	 * (SCHED_FLAG_KEEP_PARAMS): they are the ones the task has, and
+	 * sys_sched_setattr() read them from it with no lock held, so a
+	 * change of its own that landed in between would leave them stale.
 	 */
-	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) &&
+	    (dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
 		retval = -EBUSY;
 		goto unlock;
 	}
-- 
2.47.3

