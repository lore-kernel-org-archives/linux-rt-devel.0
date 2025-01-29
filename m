Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0FE1E2843
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jan 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182554; cv=none; b=Jcj3W8N+MDhJJ3Zjs7BlVHeEIQ6M6xIP1uWOSZUHGwrDx0ONe5ZttpELpyFuNGhdgNzpUFShq7TwpN/mN58+w6TlIclrYf1lM3MZ1ZUTjWPufIVBJLP0mJy8FvyDpjflV8TQTMbNKUQVLY8QHlftWpSPy/kOAJq1KD1DmuMInxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182554; c=relaxed/simple;
	bh=oMD7e0gofa5i9if2eNagjdWy/tykWi1nJkrKgxug8gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojxi4dW9J+IS2tGUoK4gPjRFP/dRJ0zYx5U5Zk2vAflkKv3JwUonw09NvxV3dejd/DbJsWWmsR+oPKmjhQcA9v76PcssXAqgmvtZilGbXItVtiHWhkTF/57C/nzjbPqpTw+zjSKLpMEUv8KRDiGXSCdQUiw7QQVTfgYeTCJIjqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qiN2V2Fx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=60jk1j2G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qiN2V2Fx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="60jk1j2G"
Date: Wed, 29 Jan 2025 21:29:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738182550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRDQVIgtqQrwqIXTO/k9zOIClAfj5rG+/oWyOh94tLg=;
	b=qiN2V2FxzKwMdiQeoxM2Kl1QAhvgTh1Ey6tZkPgmyylD9VarPdj5LEhvfxNzNNWaZmSyvb
	EQzikgS8Sgyz5Rcc4gAtyBTFVDVIYQRHDmYYqEVvoyL8v7/p6R0lQ8SaIbeBQkV4CiKG6A
	uRM0/k6ozvBewUMmPQzrl8aXJNiHWc8K0G8HIHxEugHTf1qp+AZM0zeVVcWdz5zZBGxF/k
	TJPnolfDFAs0HGmBcKQIGc08UxWR8YZqMVWU7w8jyQ38ErjVcmpM/I6p2B9pCkncIws4O1
	t+cpZAbEMANU4zKVqC9c35WWYo+axueAHe9xCHa5TbEiqXETDNUajE92xzIVTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738182550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRDQVIgtqQrwqIXTO/k9zOIClAfj5rG+/oWyOh94tLg=;
	b=60jk1j2GvqQMxXeLCqQy0Tgt4sP/oe5L0rEWrJWEYEUlp3a9ofLIHm29D/sZwRhwFHAHW7
	IQeBPmHhw587atCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <llong@redhat.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/2] clocksource: Use get_random_bytes() in
 clocksource_verify_choose_cpus()
Message-ID: <20250129202909.GQNNqNoH@linutronix.de>
References: <20250125015442.3740588-1-longman@redhat.com>
 <20250125015442.3740588-2-longman@redhat.com>
 <20250129163442.vczSGi63@linutronix.de>
 <5abcb42b-91be-4043-a138-5d97cbcb5378@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5abcb42b-91be-4043-a138-5d97cbcb5378@redhat.com>

On 2025-01-29 12:03:34 [-0500], Waiman Long wrote:
> I guess we will have to break clocksource_verify_choose_cpus() into 2
> separate parts, one without preemption disabled and other one with
> preemption disabled. I don't think it is a good idea to just use
> migrate_disable() as we may get too much latency that can affect the test
> result.

Something like

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 7304d7cf47f2d..bb7c845d7248c 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -373,10 +373,10 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
 	cpus_read_lock();
-	preempt_disable();
+	migrate_disable();
 	clocksource_verify_choose_cpus();
 	if (cpumask_empty(&cpus_chosen)) {
-		preempt_enable();
+		migrate_enable();
 		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
 		return;
@@ -386,6 +386,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	for_each_cpu(cpu, &cpus_chosen) {
 		if (cpu =3D=3D testcpu)
 			continue;
+		preempt_disable();
 		csnow_begin =3D cs->read(cs);
 		smp_call_function_single(cpu, clocksource_verify_one_cpu, cs, 1);
 		csnow_end =3D cs->read(cs);
@@ -400,8 +401,9 @@ void clocksource_verify_percpu(struct clocksource *cs)
 			cs_nsec_max =3D cs_nsec;
 		if (cs_nsec < cs_nsec_min)
 			cs_nsec_min =3D cs_nsec;
+		preempt_enable();
 	}
-	preempt_enable();
+	migrate_enable();
 	cpus_read_unlock();
 	if (!cpumask_empty(&cpus_ahead))
 		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",

> I will send out a v3 patch to fix that.

should do the job. It is untested=E2=80=A6

> Thanks,
> Longman

Sebastian
