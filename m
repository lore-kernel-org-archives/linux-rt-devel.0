Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826738;
	b=amkaf2/1on+nkeY3f2GIF7C0roSEsoFmdLJdbegw4pXoy4hbOUj9tc4oWC4XM/265RTw
	 cHhxMPNLoLX6q2xeCsrO0rR4DVkdCccqOwJebksU+rvax5/uiv9LQOxKlNgqWW1R/TncY
	 s0KusqZeOoomlurVFqcFVOiEW7wRqlNfIeyxhQ112No0W4axcVWlOU63VPBrRhQFjeD6t
	 wKPEhDPIkkIiAjzFLXHh+Q1dTRgN9A49IGObAVK6niNXI2SJGF78ahUU5rRLeoqA0r0kA
	 FdDtWDKx7zg9isq3dbC0JcajTKYCm5HRNGkQGO0BcH8wL95f3TX8RehZPyI2LM9Q6Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826738;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W1mKRs0LM9yM85rfKo7VsdleSmQP3VzwQ3CUf1XJXIk=;
	b=1u2OXG7ibWEWy/E15HLn1b+R7mDoXQJ3j0uM/Uzj18Wwc4jgVRyIk6+VXaYMW2dnYZoM
	 QvJ5xIRpDcoH0p3Q/+mEgcd//m9tXiF0XAkMrVetEyJFT5RkAPWoYAtH6BH3RrAD+l5JE
	 MO3w4h2lJudGrMkuPTB3axZitON3P4TvgDS/jADZPY0M2ffliK46T8z2GG6mCf4jqTbNn
	 vakSA22W1MmcJXQJV/Cw3R00X2nzj/mQtaLURRZPZPAX+utHt0z1+NMESqc5+U5pIAc6a
	 Bw9GOpIfrrHw60jsM0lD1C5CopaWXfGJlOM7KaCvfe2yYX2Il9J8fioTmDKUJZobOGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Sk+ugbGV;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D160820A1
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 21:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A4D160820A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Sk+ugbGV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793826735;
	bh=W1mKRs0LM9yM85rfKo7VsdleSmQP3VzwQ3CUf1XJXIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sk+ugbGVT0BS6DCf/K6hOowud2RHNADFYTfQ+SWI9w5t7rdLAACSFCrTeu7YEU6gJ
	 +hsuCXLJaODG0aL0Dfa7CsSYZEyp67xpEWmgMIhT6WwCLksfR0SZ1qNxLcSPS72Pov
	 +ZaeK080Fe41xBAYwfeCdJC96yYiX9qg53GiZKbA4cYdUmuovyuMRLJQnCNSnXN69/
	 8+EYhTteiHhV+Kcy7Eu2smuSDK0GyuV/uPIpxmvUSxNZnpTg6BGTpJl6IoMfmGX/Wi
	 ShVknVes3urDtKsVVKEB9HPoZotirjEOHx7oxX15KXFBrkQiqYkydn5eqiuw1Cm3LT
	 k9bdcAfEMcjoQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jKdRz4cfBzLXj;
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
Subject: [PATCH v2 19/21] sched: Clear cpuset_locked where the policy check retries
Date: Wed,  4 Nov 2026 16:12:05 -0500
Message-Id: <20261104211207.1392343-20-mathieu.desnoyers@efficios.com>
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

The retry of the policy check in __sched_setscheduler() drops
cpuset_mutex and leaves cpuset_locked saying it is held:

	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
		policy = oldpolicy = -1;
		task_rq_unlock(rq, p, &rf);
		if (cpuset_locked) {
			dl_accounting_unlock();
			cpuset_unlock();
		}
		goto recheck;
	}

sched_setparam(), and sched_setattr() with SCHED_FLAG_KEEP_POLICY, take
the policy they check from the task with no lock held, and take
cpuset_mutex for a task of SCHED_DEADLINE. A switch of that task out of
the class meanwhile makes the check retry; the second pass finds no
deadline policy to take the lock for, and the exit path unlocks a
cpuset_mutex that belongs to whoever holds it by then.
dl_accounting_mutex, added earlier in this series, goes the same way.
CONFIG_DEBUG_MUTEXES reports the unlock of a mutex the task does not
own.

Clear the flag with the lock.

Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/syscalls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b1fc4fadd689..d541f4fc7252 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -654,6 +654,7 @@ int __sched_setscheduler(struct task_struct *p,
 		if (cpuset_locked) {
 			dl_accounting_unlock();
 			cpuset_unlock();
+			cpuset_locked = false;
 		}
 		goto recheck;
 	}
-- 
2.47.3

