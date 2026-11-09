Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231495;
	b=owDw89P/OLmt2Tizzo30Eh6JtwnzGihBdm1UN+zej6Pm3JmwzjpthKcT9yp7uoC9gkOr
	 qQ2q1EZLyMv/CHMXUTia8eNn6mIf9Ayl7o9EeTHbgXlptkygMafulZAD/vgg8s+Q8Y6+B
	 /6GR2IEAo/6hVC5lJhZjhIKEeJFKOxLTnBxtjENsegzW1d1pkt2F9kHroqJ9WuDrKSkJu
	 5wjMtfoM2wpxFXS0fmwtmBe4n5ePgTMNauSZO1bg8E2UQWGPUgzYK8zGpUMTsjheMuzJi
	 RhdQt+AtGcQJu9CBml+7R2FmzfACblWuqLjR6vbQjXt4dBY4eK9b3ga3Qe62Xhr05gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231495;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=BGYsCV+6ghrjpGJ3qQugEb8Y0kCPQvn96f3QlByPPhE=;
	b=uhXIYVY+DHfGBTskD330V43BMBOIrRTgUCUw6fBz5jN5t14fSYapeJs0xNSzhBgVqaLx
	 AL+F1TJcdVS+yxQT1c6kbs7NJB3crg+eDubXAHsOtQF4UB9gjU2LkMsbNPMN48offOn5D
	 kD/gnChPOnCrjumbRds6lsCBpRyd/X4jlhbjf09t3vb6lnw4LlFTp18xxal/LCj0uh5Lf
	 anG1fRctk/L+hQr5WFUOeviKv9qBJrgBLWshfihQGvIUlhY7ZiC/oLmN3MssWSQKMgDPb
	 zashAfVcRUlZe2jS94mfiO8hxk4ECX7ImBzjduhAAnD3cqBLw1Hju22nNEQfxFg14Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VUtCOFoi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666B606A322
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 13:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A666B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VUtCOFoi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794231493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGYsCV+6ghrjpGJ3qQugEb8Y0kCPQvn96f3QlByPPhE=;
	b=VUtCOFoin3YsnZlHv1bGq3yzV7qv02AZiKSQEwCqxciMjpsbtAYhunQCGP+3TJqorp8+7s
	XHva+KGu7ZSpUVy+QsQTGaGCv+s3xM3wiDikmYx+0gUM8sL7j5BEVbS58Ap38Ws2v8NlWY
	aPRNxjHsXiCuAMXedfUcgPN2MLoOSMU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-zoqfnp02PaO7C-YndXATRg-1; Mon, 09 Nov 2026 08:38:11 -0500
X-MC-Unique: zoqfnp02PaO7C-YndXATRg-1
X-Mimecast-MFC-AGG-ID: zoqfnp02PaO7C-YndXATRg_1794231491
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e00f3929bso504024f8f.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Nov 2026 05:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231491; x=1794836291;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGYsCV+6ghrjpGJ3qQugEb8Y0kCPQvn96f3QlByPPhE=;
        b=z3nKVaKrIBumkLb2K9c1G1vzqx1BOToUhnAA9aIqbA7cjxRDi2i1LsYz48lcVYWy2C
         g1tHoKjx55ho2PUMhr8JZ66fkZKM29CaptNP8ctitgIwNDkrUJliUqU4i0/Haqn915pI
         Fu5BVf9pFzW+1cWNBW4Xb2gCGRANHQHxqILXCYAEYlCmrdsL9rY/VtPoUf24lHcVy7gB
         v66VyWenbHP+/X112el4uLMXcSKdJedIXE8KRfKodJkqxsSEjsPe3Mr1i6NuG3cTuecD
         dsldvoCGn6XXvwbyMhqhsIEHVwyQbdL1enj1S0zKKVfSQ1jqpK1UD16rNvNnGA+QLV9t
         /PvA==
X-Forwarded-Encrypted: i=1; AL+hErFqxXdDi+95jAuxdhh6L90Xo1jzi+nQ1zsBzKrEJ7P53CXDn7gWToG1wvS6jJuaeN7eJgGLPa/oXBwo7InLig==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Og2noQ/TPR+pB5oFmIc3Zl19//5t53X+LFwQhhztodrzgNW3b
	fQ/dAHq48HcWDaMXjf0b8Tehl1VEXpVBdBFcg8GiGoUC4/hV/3WbdHHsHwizR17S1cgwJ0k5CU2
	MYyGLoTD7T3RIQN/44gNb76Ie+mBxcOJUOrET29PXAGqOY3YLvYZDbJfl8QYjv7PbZ4ll
X-Gm-Gg: AYBFou2LUWRmjQYuRfv06e/1bAkm8QWFbsRdQi0ItkWAhnDy2XBLG3HFSisajRPCljn
	zXkuYIdIpEVsWMIDFYT/wZAdvCYABDiWqloceKXUFRYms7PqNXkXMQhYauSoJoA9pA7J7uIXU1d
	c30PnWndeMj7Rp9AZxaFhg/TlO9ArasLB1+uUTdumLKkXkPVzweZdseMES37qepZFYgq+bwQQ5/
	Ht5oDCVd35YhbaH+V1WcA+vCLpqBpQ9oKNyeUuSQyqBcBnenWB/j4oLhb2NIaKyJgKiR5nD512e
	x899D9y5oA7OiqqIfthr5qKItj/cNOsf/V8ALSyEqE3mXQOMxwrO1S2veZ0C2OGD3VXw3aXfPNM
	0xr3bhPpChr78N3luSRhpuRljNRp9sGQHV6uvGIW40Q0Sd805DpblE59YWf02zIiHx5GV0wz8Cx
	2lkw==
X-Received: by 2002:a05:6000:240f:b0:48d:f160:efad with SMTP id ffacd0b85a97d-49425566d13mr15141594f8f.30.1794231490546;
        Mon, 09 Nov 2026 05:38:10 -0800 (PST)
X-Received: by 2002:a05:6000:240f:b0:48d:f160:efad with SMTP id ffacd0b85a97d-49425566d13mr15141537f8f.30.1794231490148;
        Mon, 09 Nov 2026 05:38:10 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597652ca7sm10965139f8f.39.2026.11.09.05.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:38:09 -0800 (PST)
Date: Mon, 9 Nov 2026 14:38:06 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 04/29] sched: Let a task boosted by a deadline waiter
 change its policy
Message-ID: <avHMvpJonTciAtx_@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-5-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-5-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RZRYqIA2I-7qRg1Kecb_Mx0ipxYXHyVcr1ys0oOPna4_1794231491
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> A SCHED_OTHER or SCHED_FIFO task that holds an rt_mutex can be boosted
> into the deadline class by a deadline waiter. Then a sched_setattr() or
> sched_setscheduler() call on it fails with EBUSY, unless it asks for
> SCHED_DEADLINE. sysrq-n would not reset it either.
> 
> The admission test runs "if setscheduling to SCHED_DEADLINE (or
> changing the parameters of a SCHED_DEADLINE task)", as its comment
> says. sched_dl_overflow() then handles three cases, by the task's
> policy: the task enters, leaves or stays in SCHED_DEADLINE. But the
> call site tests dl_task(p). That tests the priority, so a boosted task
> passes it. For such a task and another policy, sched_dl_overflow()
> matches no case and returns -1.
> 
> Fix this by testing the policy, with task_has_dl_policy(). A boosted
> task has no bandwidth of its own to admit or release.
> 
> Now sysrq-n can take a boosted task out of the class.
> normalize_rt_tasks() calls __sched_setscheduler() without pi, so the
> task gets its normal priority. Nothing then drops the boost. At the
> unlock, rt_mutex_setprio() sees no change of priority. The pi_se of the
> task would keep pointing to the waiter, which can exit. So also drop the
> boost in __setscheduler_dl_pi() when the task leaves the class, as
> rt_mutex_setprio() does.
> 
> The boosted_owner_policy case of deadline_bw_test, added later in this
> series, fails with EBUSY on v7.4-rc1. It passes with this series. The
> sysrq_boosted_owner case of deadline_switch_test tests the sysrq-n path.
> 
> Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

