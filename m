Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910927;
	b=2raO0/R6BU3MS/v9R2BegO+npslKQGKr2qsC8ZR0vUBJB4yhTof/OYUuI9qKwSAuxxbz
	 Y7KtCrILoF12U3XcdJ9LRjMMOE/Eb3uiR55MUWhh7S8wdjQGh82K3h5l/Fy6Uszr0okbX
	 BhvVEWysmbFJGCc4pq3bS63T38QwOfcME/vKNR1hGnHRNwLUXYwnTdZbr8aFNpf9mOWaZ
	 mm+DyuF8ijLd1zYjhR6RJgLePvqWkfGffq9wcwORCPCdfYf9zlMOnVwGW3ybYre54H3Zp
	 /k530giKxErJmUrTHR4+0GmSusb9CK5oNqahBa1udxkLjMOgzBq/ZvTRAe1RWIa6m4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910927;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ek88mUADN7Q+v+B3mP2BWCJjP45ejN496oxJwiHaM+0=;
	b=jSe8XUQ43vPOY7NgHcCMpG8tzXuPmD0IuWlwAbxkNN0JFsS2kL7yUXSU9ife2lsEgehI
	 uc12FoquBlh+5x1tsyUSa11mdJ0OIHTBDPB9ULV2R78nccSJev7XBgVRaa6ZKn462PnOL
	 saK8NdMUxvgGje7rJxdBy2k2AMvVt25M90JyQPuMgABQKPteU+XQNdm/Q3wLpwvoNwCH7
	 dXbgLynAXPQ7iUfXv/eTBVw2l9InMLrZQAbofFvPTWAefpE+EeQHbw6dL3nJMgf71IRDP
	 omT9/XRRZzPjC1ff7Uh1PG6Lsl7zPGlreRXzuN15xfCTTO4joYF2N0jAIOgnOvgjfNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Un3J6mQl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6AF606D813;
	Thu,  5 Nov 2026 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Un3J6mQl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F21A1F008A1;
	Thu,  5 Nov 2026 20:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910926;
	bh=Ek88mUADN7Q+v+B3mP2BWCJjP45ejN496oxJwiHaM+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Un3J6mQleL9hAsn8hJ/Nyfnbr4vzJsTdecUip8PiYQeosWM2NalX7zUWrVRW3Utqh
	 tMe1VsnFqYg9Pd/f+Df2m3DzV1vm2OZA/pT0HYFcKikAHVZqOK1Pf5aD6dIK7POfDy
	 c2xD+iEDQ0NWtR5OjJLIx5hWVw+B/XZfBnCKP0i1nZtM1AFqs7UyComr7aqqXj0FP0
	 EmLwd1WzGHvZ1HgBTAXsVECpCoZKfe700HIB+KbIH65zPWeMswIimFaMHvaginvA7f
	 8K79PGUtD+dlCk+Qf4wz75ZJIxWLj3r43wBdlZx2wAjdJFqJw2fkNIc+n6LLyF8Hnr
	 gStj8EQEZPjNQ==
Message-ID: <sashiko-outbox-200114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/24] sched/deadline: Do not take a waking task's
 bandwidth off a runqueue it left
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261105193359.1450487-12-mathieu.desnoyers@efficios.com>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
 <20261105193359.1450487-12-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:35:25 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sched/deadline: premature bw release and state reset in switched=
_from_dl()
--

commit 32169fc2d3492f6357debcf70a3512a72875ebc4
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not take a waking task's bandwidth off a runqueue it left

This commit adds a dl_bw_oncpu flag to struct sched_dl_entity to track
whether a task's bandwidth is currently accounted in a runqueue's this_bw.
This prevents double-charging or underflowing this_bw when a migrating task
is modified or changes scheduling class while sitting on a target CPU's
wake_list before being enqueued.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 37b931fc2faf2..d4cd5b5fb27b7 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -2789,6 +2810,11 @@ static void migrate_task_rq_dl(struct task_struct =
*p, int new_cpu __maybe_unused
>  		 */
>  		cancel_inactive_timer(&p->dl);
>  	}
> +	/*
> +	 * Until the enqueue on the CPU it wakes on charges it there, this
> +	 * bandwidth is on no runqueue: the rq of task_cpu() is not the one
> +	 * it was taken from, which dl_bw_oncpu now says.
> +	 */
>  	sub_rq_bw(&p->dl, &rq->dl);
>  	rq_unlock(rq, &rf);
>  }

[Severity: Medium]
When a task blocks before its 0-lag time and then wakes up on another CPU,
can switching it out of SCHED_DEADLINE while it is still on the target
CPU's wake_list prematurely release its root-domain bandwidth and reset its
CBS period state?

When the task blocks, schedule() -> dequeue_task_dl() ->
dequeue_dl_entity() calls task_non_contending(&p->dl, true), which sets
p->dl.dl_non_contending =3D 1 and arms p->dl.inactive_timer for the 0-lag
time.

If the task wakes up on another CPU before that 0-lag time passes,
try_to_wake_up() -> set_task_cpu() -> migrate_task_rq_dl() subtracts
running_bw from the old runqueue, clears p->dl.dl_non_contending =3D 0,
cancels p->dl.inactive_timer, and clears p->dl.dl_bw_oncpu =3D 0 via
sub_rq_bw():

kernel/sched/deadline.c:migrate_task_rq_dl() {
	...
	if (p->dl.dl_non_contending) {
		update_rq_clock(rq);
		sub_running_bw(&p->dl, &rq->dl);
		p->dl.dl_non_contending =3D 0;
		cancel_inactive_timer(&p->dl);
	}
	sub_rq_bw(&p->dl, &rq->dl);
}

If try_to_wake_up() queues the task on the target CPU's wake_list via
ttwu_queue_wakelist(), p->on_rq remains 0 (!task_on_rq_queued(p)) and
p->dl.dl_bw_oncpu is 0 until sched_ttwu_pending() runs on the target CPU.

If sched_setscheduler() or sched_setattr() switches the task out of
SCHED_DEADLINE during that window (such as the switch out and back in
described in the commit message), switched_from_dl() sees
!task_on_rq_queued(p) and p->dl.dl_non_contending =3D=3D 0:

kernel/sched/deadline.c:switched_from_dl() {
	if (task_on_rq_queued(p) && p->dl.dl_runtime)
		task_non_contending(&p->dl, false);

	dec_dl_tasks_cs(p);

	if (!task_on_rq_queued(p)) {
		bool released =3D false;

		if (p->dl.dl_non_contending) {
			sub_running_bw(&p->dl, &rq->dl);
		} else if (p->dl.dl_runtime && !dl_entity_is_special(&p->dl)) {
			dl_task_release_bw(p, task_cpu(p));
			released =3D true;
		}
		sub_rq_bw(&p->dl, &rq->dl);
		if (released)
			__dl_clear_state(&p->dl);
	}
}

Because migrate_task_rq_dl() already cleared p->dl.dl_non_contending and
canceled the inactive timer, switched_from_dl() treats the task as if its
0-lag time has already passed. It immediately releases total_bw via
dl_task_release_bw() and resets runtime, deadline, dl_throttled, and
dl_yielded via __dl_clear_state(&p->dl), allowing another task to be
admitted or the same task to switch back into SCHED_DEADLINE with a fresh
full budget before its 0-lag time.

Should switched_from_dl() also re-evaluate the 0-lag time via
task_non_contending(&p->dl, false) when !p->dl.dl_bw_oncpu?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105193359.1450=
487-1-mathieu.desnoyers@efficios.com?part=3D11
