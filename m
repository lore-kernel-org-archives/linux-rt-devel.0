Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857435;
	b=nkme6Jfz0X7/G32K6p45nMAJy7i23hiJousQIB+ZKaj3R1/d0WdgawhnrgqB729d/lVv
	 NkGcw8/1fe8XmFKwpvqtLNYn1eD+HNTSxmsucRmocWFreLKshXXUZ5YBhPMOy7B2KxYU+
	 rHwugX1HuM6NsovXv5SCjpj/TJXY8pSkVzlBoFdojzqxT8Ay7xcNEBcNrPenq0QHSsFeL
	 UODC01eT4BXPXfxX0ZkKt1OVFq6l0JJ3W2Xy9p43G8M5qQoIcFU4oX8gug1musz2hqN98
	 RChcUoktihr5/++RkoO7hRKLguAuX3czuK53FsANqNKNr87z26aeKP7N97OcfzyKFNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OCj8FSyVowVZDJHe/EutTO4zUsFk7DZFN85PCZ/7JyA=;
	b=fh9H+82nrbICb21GpgGFlf+zrGIhrsvuRnwpHJ6krRe85yM499DXehNPGaSHEYPfEuY3
	 e7PMB53tv5EhV+M0aaTUBcYmuyqxC61IEbbWG1lNOxulvJ8E/KABNPS9csq12eKvZG7rI
	 Ce4/FbxLepNWAmGwTNB5V+LUXEz58T+Ida7taWWYFuPqOAhpD982oqdRFAvxEW0f0/BsS
	 hb829HgSL9VUuVtmuUZvrQ94aGVfFVMCr/Ur31tHqMab+3Ix/Zjf5eWLvc6HGZQcuMEpI
	 oU6Wmzo/75EYZsWRcl7WrIrgrUXr64uDVYu66ZBE3OwlVNCLECyUFLHPshHVjLqDsPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyhRGMtL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A4606A31C;
	Mon, 16 Nov 2026 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyhRGMtL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51161F000C8;
	Mon, 16 Nov 2026 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794857435;
	bh=OCj8FSyVowVZDJHe/EutTO4zUsFk7DZFN85PCZ/7JyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UyhRGMtL+RMIc/tDq/Lxz1xryDJQwO5Q98tEgF1/sR4IHOGqAPsf8pMGghVBBm1C4
	 rUKzrY0g1Kpqf4eVXkWcEsLsW6QGyBpwCaiXUDK0x+iWDEdD0uRkqYp8mOV1iIA4g6
	 7lnG6jSKPNKiM3hL478XLVqpOG72YofyUhNBpRNoda2m/irr9OPJONpsZkyiQfe4kI
	 av183ShOnRvzvoFUfm+PegIlQ7Zy/ug+LgBpDdc/SNZCjxqYa/ze7L626uSN6XF2f4
	 Ni8zWoqNwTQQKhEp8/uoNnc8Nx5O9vRa+a30KLxSQDA6ieDbBkraMkAefWAoRSf+Jy
	 QwKvgM+ZBzKPQ==
Message-ID: <sashiko-outbox-217565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/37] sched/deadline: Refuse dl_server debugfs
 writes while the rq is offline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-6-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-6-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:30:34 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] sched/debug: sched_server_write_common() misses CPU
  deactivation window
--

commit 20746e8301600abc34772d08e7fcdc3dbeb36656
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Refuse dl_server debugfs writes while the rq is offline

This commit replaces the cpu_online() check in sched_server_write_common()
with an rq->online check to reject dl_server debugfs writes while a runqueue
is offline during CPU hotplug transitions.

> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index e6a3b516c703b..e0d6cd3bd607d 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -410,7 +410,15 @@ static ssize_t sched_server_write_common(struct file=
 *filp, const char __user *u
>  			return  -EINVAL;
>  		}
> =20
> -		if (!cpu_online(cpu_of(rq)))
> +		/*
> +		 * Refuse the write while the runqueue is offline. This
> +		 * includes the windows where the CPU goes offline or comes
> +		 * online. The root domain then does not count the server's
> +		 * bandwidth, and may have no active CPU. rq->online is set
> +		 * under this lock when the CPU joins a root domain that
> +		 * counts it. cpu_active() is set before that.
> +		 */
> +		if (!rq->online)
>  			return -EBUSY;

[Severity: Medium]
Can a debugfs write still slip through during sched_cpu_deactivate() after
cpu_active(cpu) is cleared?

CPU0                              CPU1
sched_cpu_deactivate(cpu)
  set_cpu_active(cpu, false)
  synchronize_rcu()
                                  sched_server_write_common()
                                    guard(rq_lock_irqsave)(rq)
                                    if (!rq->online) // still 1
                                    dl_server_apply_params()
                                    dl_server_start()
  sched_set_rq_offline(rq, cpu)
    rq->online =3D 0

During the synchronize_rcu() window, rq->online is still 1 and the root
domain has not yet been rebuilt by cpuset_cpu_inactive(), but cpu_active(cp=
u)
is already false.  In dl_server_apply_params(), dl_bw_cpus(cpu) and
dl_bw_capacity(cpu) weight rd->span against cpu_active_mask, so they exclude
the deactivating CPU while dl_b->total_bw still includes its server
bandwidth.  If this was the last active CPU in its root domain, cpus and cap
are 0; if other active CPUs remain, __dl_overflow() checks N servers against
N - 1 CPUs' capacity and __dl_sub() / __dl_add() miscalculate extra_bw
across N - 1 CPUs.  dl_server_start() also re-enqueues the server on the
deactivating runqueue after balance_push_set(cpu, true).

Checking (!rq->online || !cpu_active(cpu_of(rq))) under the rq lock would
cover both the activation and deactivation windows.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D5
