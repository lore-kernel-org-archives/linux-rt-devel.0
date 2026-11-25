Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594368;
	b=PNUUYu+y5sjtoB3XTSTaTDKq+Fsmt4cwQkop19snmYJHS0wZ7O91xtRmdZvIMlDYvhIN
	 o63NhFUvlInPSlwIVHfjk1v5TQp88uYH7pulV11NV1eI1DzzgBnNRWPSnX/hlU9upCHt+
	 o3rAMG61l1wYlz1/kxuhQeIdobZpHu96Jx9pk0Ux3W44Ttp9e2PJ0upwftd0iSIyDiLyG
	 MQLUOc2tmcqdsv7uZVM4wpxw38l5LrGyIho3/UEkRZ1O8+4zRPh2SKqYppkfCkO0kp8O2
	 EEqfjcYh1rQaN+ZfNJmEieqcjedVrGZLJpRnfOqpTl7Uc5ak/iRaxM7Su19fEwmPsyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594368;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vRtTUvGo0zxmvDxi7Ox+UCHuNCQ7tGvmHkJu+NApSOI=;
	b=G+1Uq2BuHizt59ltc5pYcjKMTa6bpvlpnqiD4p1jwC1gDCdkCFSCmUJJ1Tt5pTcFfzLC
	 fNiiYrie0pzprJze7ZGFrtdDRdD02SaIv93aNYT8nCKOJI/0OOrrvJ9NkY1lKuzzPuILx
	 7FEJe9Jc+NXAm2flB3feePk4Tuy1pT9rqwI9zvbiTPSQ+VSYR2J2fSMCjsByAD+wzs2As
	 4ipz/W+dfKpvv7h3DXMTCLkZQ0WnEAjct1i+ARvnviutAbp+OskhBSa6GwVI+0X0kiWE5
	 N+NIPce1mahka062oZD9VM+OSoE7opb/8m7AHK5ipSEWkhd5l993Su8b5lHxRhXeI9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6twI3Rn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C53606A321;
	Wed, 25 Nov 2026 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6twI3Rn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A9F1F000C6;
	Wed, 25 Nov 2026 08:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795594367;
	bh=vRtTUvGo0zxmvDxi7Ox+UCHuNCQ7tGvmHkJu+NApSOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j6twI3RnMLGE8TAS22mMadN9WhV5A0CqzUBvkQCAdIb/kvq6yQvmO7CVk9JvfiZ7S
	 a+g6qIatSzQLnLeworwI3hpqIrSBKTKX27i9dPkPnvZAnSgFdqJeAxbxpg1VzngX9d
	 +6FKoJmKr3jztfjo9K5N+eRlKERyhkvUn/dXiWE3HthHN6ILW8YMXKoRXhCFQNPz86
	 GpVNz8E7NfNeO780IGi9XpyOCsRYwSslnhJzzS1qHOv8cZUyMt1rb88r3aWemAVEPx
	 eXtQUuR9bcO/qd738ubBqhxyGm2Dumdp/MgEwn1xro50raUKaU2fEthXPBRphrXtRd
	 97Win8n+40XSg==
Message-ID: <sashiko-outbox-232874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: Run irq_work in hardirq context on
 PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhongqiu Han" <zhongqiu.han@oss.qualcomm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261125080613.1138573-1-zhongqiu.han@oss.qualcomm.com>
References: <20261125080613.1138573-1-zhongqiu.han@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:12:46 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] sched/deadline: unallocated bandwidth subtraction in
  dl_task_needs_bw_move() [1]
--

commit 6dbfa989b510ecc8b3f76fbbc75d3d06fb5180f2
Author: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

cpufreq: schedutil: Run irq_work in hardirq context on PREEMPT_RT

This commit initializes sg_policy->irq_work with IRQ_WORK_INIT_HARD() so
that sugov_irq_work() runs in hardirq context on PREEMPT_RT instead of
being delayed behind runnable RT tasks.

> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 14405a6149911..b2e9ac7e35172 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -726,7 +726,7 @@ static int sugov_kthread_create(struct sugov_policy *=
sg_policy)
>  	else
>  		kthread_bind_mask(thread, policy->related_cpus);
> =20
> -	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
> +	sg_policy->irq_work =3D IRQ_WORK_INIT_HARD(sugov_irq_work);
>  	mutex_init(&sg_policy->work_lock);
> =20
>  	wake_up_process(thread);

[Severity: High]
This problem wasn't introduced by this patch, but can binding the sugov
thread across exclusive cpuset partitions (root domains) here underflow
the source root domain's deadline bandwidth [1]?

sched_setattr_nocheck() configures the sugov thread with SCHED_DEADLINE
and SCHED_FLAG_SUGOV, which sets a non-zero p->dl.dl_bw while skipping
root domain bandwidth allocation because dl_entity_is_special(&p->dl) is
true.  If policy->related_cpus lies in a different root domain from the
kthread's initial CPU mask, set_cpus_allowed_ptr() or kthread_bind_mask()
calls set_cpus_allowed_dl(), which subtracts p->dl.dl_bw from the source
root domain whenever dl_task_needs_bw_move() returns true.

Unlike dl_add_task_root_domain() and dl_task_check_affinity(),
dl_task_needs_bw_move() does not exclude dl_entity_is_special(&p->dl)
tasks, so __dl_sub() subtracts bandwidth that was never added, triggering
a warning in __dl_sub() and corrupting SCHED_DEADLINE admission control
on the source root domain.

[1] https://sashiko.dev/#/bug/linux-a604bbac-776b-419e-820b-f5a41a07ff1c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125080613.1138=
573-1-zhongqiu.han@oss.qualcomm.com?part=3D1
