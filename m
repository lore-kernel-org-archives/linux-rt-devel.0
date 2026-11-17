Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926336;
	b=5B76n8kVJelf6m/Oh+YB9Y0dFryCgrO2O0w1Rh6/rzz0/oGiwscvm5aRcw3q5TNVzAaY
	 eGkjgKUMAC8160HZ36vul6tI32IohBBSgA8H1v65b8e+/jIrnj2Ws7VeuLcgv9r444L4u
	 kmAynU+1UGaASSH6VIPAkQAC9DfSRWqxhQ8hol0ZuHTma/IUj8x9Lyn/whU0JpQF1TGgx
	 xHkU7zOc+va70sCWOSNR+61kTXnyDkAtUnLkPPUvZzWAxXXEdyBYxh85lm7xlajmsCxCJ
	 TxVGUUo7SlxalaJpMMBk2/dfhQhdG3C4aIk0oiar8V8pjsQ1Z3oqOZtJbCBC49k58hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926336;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k/sW3tiPcVrf/T4i4ERuM8p7jvmYD29N3k/zmSIkPcM=;
	b=eo/kchAb1ec7S7HRfLgq8dw4n4PGux/fLT7UgRtcB4289SunyFzxtBAGKWFd8FfIhExW
	 4oiKklqrNqT2ABJ4AsdmwabigY8R2P1RZIyuPaPjtEX/O9r6ou+64Kws4aWDVVz+27A5n
	 Yi7yb+cjZBapsSktM2slykrqd40rFQuyyKruZkhycKymQzX053QaO4+PHhobKXFVBqOSW
	 3rQ81ANqX3e5gLFtwUPOVuKiyW+8JS5H4ipfvumJ8ipNt4kFi5e3qrFpZx+uSTITLFdMb
	 CRWK3XMMxNdjr3ok9LYIAaQU7UfYtlD8SF6dmR/zQJvZCFEEXJieu3cFdJQwjzAVq2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="diKclFZ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C944606A33F;
	Tue, 17 Nov 2026 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=diKclFZ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FA81F000C4;
	Tue, 17 Nov 2026 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926336;
	bh=k/sW3tiPcVrf/T4i4ERuM8p7jvmYD29N3k/zmSIkPcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=diKclFZ/hy+w2qn0p4JZUmXbCoD8LZX08yirLm8aDAc7RhD4JRz9uaWnHTyrvgCeR
	 pYb4KqrjuOPSPMNFoLu0oTWsQyXbdZ6NnIyUgCysPvcwGgjyx0fFkO3/EAnzVsdv4f
	 qiL3Yp+49VnRLqk45CpFhiYGAMzP8OQEEf/eWrmz6kImuVB43UWD9qQ9SrAfeLz6Hz
	 /EhsFRz7olPH8x7HDjgnOqFx5Wu8bOaTfk+sJocPACnbv4MzSqJbBIS1MuVQwWOOD2
	 JXWJt/+DpGJh0elSMYpBAHf5ZI0kMrF41Z0cbDVv3V3aHa+fRkcUXkxw4d4M2XpAuU
	 5/NSTTJ/qAt3Q==
Message-ID: <sashiko-outbox-218977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/40] sched/deadline: Refuse dl_server debugfs
 writes while the rq is offline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <2bee6a143319301f082855a15274f0563e99b8a5.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <2bee6a143319301f082855a15274f0563e99b8a5.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:38:55 +0000
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

commit 6c51bc6b398f0bfbd0028d2f5672f277e0ab2db8
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Refuse dl_server debugfs writes while the rq is offline

This commit replaces the cpu_online() check in sched_server_write_common()
with an !rq->online check to reject dl_server debugfs writes while a
runqueue is offline during CPU hotplug transitions.

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
> =20
>  		update_rq_clock(rq);

[Severity: Medium]
Does checking only !rq->online still leave a window during CPU
deactivation where cpu_active(cpu) is already false while rq->online is
still set?

In sched_cpu_deactivate(), set_cpu_active(cpu, false) clears the CPU from
cpu_active_mask before synchronize_rcu(), and sched_set_rq_offline() sets
rq->online =3D 0 only after synchronize_rcu() completes:

CPU0                              CPU1
sched_cpu_deactivate(cpu)
  set_cpu_active(cpu, false)
  synchronize_rcu()
                                  sched_server_write_common()
                                    guard(rq_lock_irqsave)(rq)
                                    if (!rq->online)  // still 1
                                    dl_server_apply_params()
                                      cpus =3D dl_bw_cpus(cpu);
                                    dl_server_start()
  sched_set_rq_offline(rq, cpu)
    rq->online =3D 0

Because dl_bw_cpus(cpu) and dl_bw_capacity(cpu) intersect rq->rd->span
with cpu_active_mask, they already exclude the deactivating CPU before
cpuset_cpu_inactive() rebuilds the root domain. If the CPU was the only
active CPU in its root domain (for example, a single-CPU cpuset
partition), dl_bw_cpus(cpu) is 0 while rq->online is still 1. Even when
N - 1 active CPUs remain in the root domain, dl_b->total_bw still counts
all N servers while __dl_overflow(), __dl_sub(), and __dl_add() account
against N - 1 CPUs, and dl_server_start() re-enqueues the server on the
deactivating runqueue after balance_push_set(cpu, true).

Checking (!rq->online || !cpu_active(cpu_of(rq))) under rq_lock_irqsave
would close both the activation and deactivation windows.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D5
