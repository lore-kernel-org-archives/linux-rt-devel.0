Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262725;
	b=yhXCLXbCOP+TjqtQgb1IDe6szimKRBB1wkbiSKqC2Xq0KIDiT03j8nxsqjETELhpIsyw
	 a3hJuJI53B3CD/qPO536jGn49VZH3plHdAy3coJBDviSgvFWzr0g6GnEBnmbtZ/kquIyd
	 9XTCsA+TcteWwEJfDVqJgW+sYTUuj9zm/Iaz3kGKWou0kg1L+X0Y26kOkYojtCe481eRT
	 PZ5+TH7/uxNeER1cAg0wVbypNeeUTy+OdtcwmQgCzyEY1nbAEwfWw8OQuz2yTFDy+QAEi
	 +q9sF39Xdtc84eSiccSVvcJZhcycR9tqnTt1uZNdbe9+3rJwSb/zCxpSNr/Mq7oefMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262725;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ggb1gfyBlv33vuZ9Mjxd2uyqGrnys2+maZyswsfEr+s=;
	b=Ti/b/6Woy9ftzA4GBob1I5op0uRRhS0WXa6BkVTfMPQBJeZ4NaMKfbrqGB48782TyN7r
	 /FwRHtOA1HN/wyx6hDFxXIJh4m0edkek8unjGAYDhDh/L/vMc3+UFxfdALHN09rcliaR5
	 cGCrBCfBHGUi9DiAkwtdqtF75eWt7OShn7zTK3pHBOaW7y4uPODqQZt177XyiXYbyY5nW
	 atAIQ3fhk3dgcccp+F8a6MHllH2fwiIe+ipkEa8lTcOpGDMwaLW5gLqLys5cd3n0N4mgc
	 gz0ezFEtE8RisVdz0mbb7eg/I8jZes1BWOfbc5lr8zlQ/ha2TrEZWcc8wax2IUD43yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGtdjkjg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA3606A325;
	Mon,  9 Nov 2026 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGtdjkjg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7421F008A2;
	Mon,  9 Nov 2026 22:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262725;
	bh=ggb1gfyBlv33vuZ9Mjxd2uyqGrnys2+maZyswsfEr+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CGtdjkjgObcx2xc+jBf7GkYaDHdBy6yLZO+nkkGbJEI/ur6SW4uqnHxCp9cbX5yop
	 YGVOC/xs+0ajAb/uGkQBPsmUgSXUgFRm7B0xJkREGXYDq9exvD17zPyKfC/Y6l9Mv/
	 YEo26sZ9UOHI3jYUOchjVlyGpV0NPYt9odNc++dYVCiJMFXTh7JpGCvZCkFETfEENK
	 HUpzsjlsBk1Uc+vfwTBmpB5S8UMUqdbCPmvrhW1MRK6ApMQkUP8oa9mta8+0D2nOxZ
	 /E/DYwgF3DNUXdOna8n4bOjwIf35SoIxfu2VlTvAUhswE8e3EqgGl/PMpo2AgSMb66
	 PH28/LfstqAgA==
Message-ID: <sashiko-outbox-205715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rcu: Print CPU that preempted stalled reader wants to
 run on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <ba4a68a7-3656-434c-a51d-5c312c0924c0@paulmck-laptop>
References: <e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop>
 <7a827d0a-1a69-4be6-8b69-9a9769b182b7@paulmck-laptop>
 <0d0974b0-5235-4764-abad-0a665c27a1d0@amd.com>
 <22d0d56c-6cef-47d7-a923-1d888e224b58@paulmck-laptop>
 <ba4a68a7-3656-434c-a51d-5c312c0924c0@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:18:44 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] rcu: unused variable th in check_slow_task() causes W=3D1 build
  warning
- [Low] sched: cpu_curr_snapshot_rcu() declared outside _LINUX_SCHED_H
  guard
--

commit e43a0801750c8342c9f97761eb87e99e324c35d8
Author: Paul E. McKenney <paulmck@kernel.org>

rcu: Print CPU that preempted stalled reader wants to run on

This commit adds cpu_curr_snapshot_rcu() and uses it in RCU CPU stall
warnings to report the CPU and currently running task for each stalled
RCU reader task, while dropping the get_task_struct() and
put_task_struct() calls in rcu_print_task_stall().

Link: https://lore.kernel.org/all/a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paul=
mck-laptop/
Link: https://lore.kernel.org/all/e8b6b372-d16b-4939-aa7a-755b7149e0fb@paul=
mck-laptop/
Link: https://lore.kernel.org/all/22d0d56c-6cef-47d7-a923-1d888e224b58@paul=
mck-laptop/

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e4f6323d78555..09e05e2b6c9aa 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2529,3 +2529,5 @@ extern void migrate_enable(void);
>  DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
> =20
>  #endif
> +
> +struct task_struct *cpu_curr_snapshot_rcu(int cpu);

[Severity: Low]
As reported by K Prateek Nayak on v1 [1], should cpu_curr_snapshot_rcu()
be declared inside the _LINUX_SCHED_H header guard next to
cpu_curr_snapshot()?  Placing it after the closing #endif causes the
prototype to be re-parsed on every inclusion of linux/sched.h and
disables the preprocessor's multiple-include optimization for this
header.

> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 803a56af3259f..08699652f51c2 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
[ ... ]
> @@ -317,8 +320,10 @@ struct rcu_stall_chk_rdr {
>   */
>  static int check_slow_task(struct task_struct *t, void *arg)
>  {
> +	int cpu;
>  	struct rcu_node *rnp;
>  	struct rcu_stall_chk_rdr *rscrp =3D arg;
> +	struct task_struct *th;
> =20
>  	if (task_curr(t))
>  		return -EBUSY; // It is running, so decline to inspect it.
> @@ -327,6 +332,13 @@ static int check_slow_task(struct task_struct *t, vo=
id *arg)
>  	rscrp->on_blkd_list =3D !list_empty(&t->rcu_node_entry);
>  	rscrp->rcu_rdr_running =3D task_curr(t);
>  	rscrp->rcu_rdr_boosted =3D 0;
> +	rscrp->rcu_rdr_cpu =3D cpu =3D task_cpu(t);
> +	rscrp->rcu_rdr_cpu_offline =3D cpu_is_offline(cpu);
> +	lockdep_assert_irqs_disabled();
> +	rscrp->rcu_rdr_cpu_task =3D th =3D cpu_curr_snapshot_rcu(cpu);

[Severity: Low]
Can the local variable th be dropped here?  It is never read after this
assignment, which triggers a -Wunused-but-set-variable warning under W=3D1.

[1] https://lore.kernel.org/r/0d0974b0-5235-4764-abad-0a665c27a1d0@amd.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ba4a68a7-3656-434c-=
a51d-5c312c0924c0@paulmck-laptop?part=3D1
