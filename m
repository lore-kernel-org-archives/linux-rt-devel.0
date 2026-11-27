Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798824;
	b=pnvjCRaGsAV/pOD3JpaVrVSlZpSHMwbGf5XfOghrr6HO2tP58y2Jcka+g4n3wYuDdHLt
	 gPtctIy/n9DWhdX6ggsIVaS8aFdyEXdL7G+Yw/amjqr/qacCkrAwKZJF3Rn9rkA8XAk6m
	 iT3Jw7NBGxR+uv4gR7HLLIoPlEfuz7GJztnVc3dB8QpV+ct4t4KZWS9/a1haLURsYP9/h
	 Udms/OAZAyS4YKaZlnkY91guoP893S8mb4Vk2b9kQbvecuP6HRsUchGaa62ieKC7aE4mf
	 JNYRtmYmc+JbgVXLxFAKCs5B3t8RPx3WIpyuppERZ/TxGQfQxZunkWklMSo1Ljbbunw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798824;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HclGxdBqqzv2FrakTBZsQL/WzEiDH/swF8CRS2ZQYFQ=;
	b=zkSGEg8M2Sm0nCwLrtiO6w6ti2BIw3HAW7wRzYUJQzmjA2DawCIwEqn69QW2d/8lGeeG
	 FfPWlt7GxMk99Gi/xj3zRuv9tHhnCmrbw5J59XFVnMHONK4XLvUFl3c92d90eRi1miJ++
	 wdy+Pgdh7RrBazO3ddNu6Up3SZ+tdM6dGfFkrT1jGOQ3QB0OlRdmq/En/tPidoWbbGjI9
	 Qq3NsdEvB60LZstxuanO+NorHgmkyBNCWtMJsedbxJ7hiqZ4LPh7as6kqCtaawOwYolUj
	 qe+cbIuIfAW36yoskNFv6KOlmXf1iqc9s1f5WN2XrFIrD7+HWrgd5afJ5wqc32CDEDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xr8Zp5MR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18657606A31C;
	Fri, 27 Nov 2026 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xr8Zp5MR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5384A1F00893;
	Fri, 27 Nov 2026 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798823;
	bh=HclGxdBqqzv2FrakTBZsQL/WzEiDH/swF8CRS2ZQYFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xr8Zp5MRIdAoWfNxfAjCwxoxc7fnv4FAAcL96WeZ76lDqkobMS4/hLhft7WEiAUYB
	 QgRDgJjdW2hmpURZ/4S1nkhLVwpRtqXnC4fxVFAi3kQi2+W793GCccg5DzFHeStyti
	 4CBRZ5G2Hfj9rcZlJdYzF3FGT5egVTiWMi+RsDTbWcp7W4peRkVCXLrVdw1/QqAfeJ
	 DY9PHwyklU71qkumoBYyRKYzKDgFQ/UlHvUwsW5y7eiM1TrSFE+aZcYoEo4doMzXMg
	 6PXIu+0X6exasatBFZuNcKuslp+7GgI1BoRC9PQ4Iy4q5OqSFe15Y902joSBC/rFh2
	 bUqV4ZP0M6ldQ==
Message-ID: <sashiko-outbox-237957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 26/43] sched/deadline: Keep a departing constrained
 task until its next period
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <54e41332aec6ddeb1d060c892cbac401c936df86.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <54e41332aec6ddeb1d060c892cbac401c936df86.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 17:00:22 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] sched/deadline: premature release on active timer in
  task_non_contending()
- [Medium] sched/deadline: uncanceled restarted timer after
  inactive_task_timer()
- [Medium] sched/deadline: rq bw leak if restarted inactive_task_timer()
  races task exit
--

commit 2dd35077684652a2ea0eca365ddf10526745d71b
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep a departing constrained task until its next period

This commit keeps the bandwidth and deadline of a constrained task that
leaves SCHED_DEADLINE until the later of its 0-lag time and its next
period, and cancels any restarted inactive timer in task_non_contending().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 7dc0b71e7cce7..adcd9c9f8a9d3 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -761,8 +761,35 @@ static void task_non_contending(struct sched_dl_enti=
ty *dl_se, bool dl_task)
> =20
>  	WARN_ON(dl_se->dl_non_contending);
> =20
> +	/*
> +	 * inactive_task_timer() restarts itself for a constrained task that
> +	 * has left the class. If the task came back while the handler ran,
> +	 * switched_to_dl() could not cancel the timer, and it is still
> +	 * queued. Cancel it here, so that the test below sees only a handler
> +	 * that is running.
> +	 */
> +	if (!dl_server(dl_se) && hrtimer_try_to_cancel(timer) =3D=3D 1)
> +		put_task_struct(dl_task_of(dl_se));
> +
>  	zerolag_time =3D dl_time_to_zerolag(dl_se, rq);
> =20
> +	/*
> +	 * A constrained task that leaves the class keeps its bandwidth and its
> +	 * deadline until its next period, if that comes after its 0-lag time.
> +	 * Back in the class before then, it goes on with its current period,
> +	 * as if it had stayed. A new period at once would give it more than
> +	 * its runtime in this period. A dying task does not come back, so it
> +	 * releases its bandwidth at its 0-lag time.
> +	 */
> +	if (!dl_task && !dl_server(dl_se) && !dl_is_implicit(dl_se) &&
> +	    dl_se->deadline &&
> +	    READ_ONCE(dl_task_of(dl_se)->__state) !=3D TASK_DEAD) {
> +		s64 next =3D dl_next_period(dl_se) - rq_clock(rq);
> +
> +		if (next > zerolag_time)
> +			zerolag_time =3D next;
> +	}
> +
>  	/*
>  	 * If the "0-lag time" already passed, decrease the active
>  	 * utilization now, instead of starting a timer

[Severity: Medium]
Can a departing constrained task still release its bandwidth and lose its
deadline at the 0-lag time when task_non_contending() races with
inactive_task_timer()?

If the task was still in SCHED_DEADLINE when its 0-lag timer fired on
another CPU, inactive_task_timer() clears dl_non_contending, drops the rq
lock, and returns HRTIMER_NORESTART.  Until __run_hrtimer() finishes,
hrtimer_try_to_cancel() returns -1 and hrtimer_active() stays true:

CPU0                                  CPU1
__run_hrtimer()
  inactive_task_timer()
    /* dl_task(p) is true */
    sub_running_bw()
    dl_se->dl_non_contending =3D 0
    task_rq_unlock()
                                      switched_from_dl()
                                        task_non_contending(dl_se, false)
                                          hrtimer_try_to_cancel() -> -1
                                          zerolag_time =3D next (> 0)
                                          if (zerolag_time < 0 ||
                                              hrtimer_active(timer))
                                            dl_task_release_bw(p)
                                            __dl_clear_params(dl_se)
                                              <-- released before next peri=
od
  base->running =3D NULL

Because the subsequent check in task_non_contending() tests
hrtimer_active(&dl_se->inactive_timer), it overrides zerolag_time > 0 and
immediately clears the task's deadline and bandwidth instead of arming the
timer until dl_next_period(dl_se).  If the task re-enters SCHED_DEADLINE
before its next period, it gets a new period right away and can exceed its
reserved bandwidth.

> @@ -2602,6 +2629,25 @@ static enum hrtimer_restart inactive_task_timer(st=
ruct hrtimer *timer)
>  	if (dl_server(dl_se))
>  		goto no_task;
> =20
> +	/*
> +	 * A constrained task which has left the class keeps its bandwidth
> +	 * and its deadline until its next period, as in
> +	 * task_non_contending(). This timer may have been armed for the
> +	 * 0-lag time while the task was still in the class.
> +	 */
> +	if (!dl_task(p) && READ_ONCE(p->__state) !=3D TASK_DEAD &&
> +	    !dl_is_implicit(dl_se)) {
> +		s64 left =3D dl_next_period(dl_se) - rq_clock(rq);
> +
> +		if (left > 0) {
> +			ktime_t at =3D ktime_add_ns(hrtimer_cb_get_time(timer), left);
> +
> +			hrtimer_set_expires(timer, at);
> +			task_rq_unlock(rq, p, &rf);
> +			return HRTIMER_RESTART;
> +		}
> +	}

[Severity: Medium]
Does canceling the restarted inactive_timer only in task_non_contending()
miss a task that returns to SCHED_DEADLINE while inactive_task_timer() is
returning HRTIMER_RESTART?

CPU0                                  CPU1
__run_hrtimer()
  inactive_task_timer()
    hrtimer_set_expires(timer, at)
    task_rq_unlock()
                                      switched_to_dl()
                                        cancel_inactive_timer() -> -1
                                      task_non_contending()
                                        hrtimer_try_to_cancel() -> -1
                                        hrtimer_active() =3D=3D true
                                          <-- premature release / sub_runni=
ng_bw
    return HRTIMER_RESTART
  enqueue_hrtimer(timer)

If task_non_contending() runs before __run_hrtimer() clears base->running,
hrtimer_try_to_cancel() returns -1 and hrtimer_active() is still true, so
task_non_contending() takes the immediate-release path while CPU0 still
re-enqueues inactive_timer.

Even if the task stays asleep until after __run_hrtimer() re-enqueues the
timer, waking up in SCHED_DEADLINE calls task_contending(), which only
calls cancel_inactive_timer() when dl_se->dl_non_contending is set:

kernel/sched/deadline.c:task_contending() {
	...
	if (dl_se->dl_non_contending) {
		dl_se->dl_non_contending =3D 0;
		cancel_inactive_timer(dl_se);
	}
}

Because dl_non_contending is 0, the restarted inactive_timer stays queued
while the task is active or throttled in SCHED_DEADLINE.

> +
>  	if (!dl_task(p) || READ_ONCE(p->__state) =3D=3D TASK_DEAD) {
>  		if (READ_ONCE(p->__state) =3D=3D TASK_DEAD && dl_se->dl_non_contending=
) {
>  			sub_running_bw(&p->dl, dl_rq_of_se(&p->dl));

[Severity: Medium]
Can that leftover restarted inactive_timer leak running_bw and this_bw on
the runqueue if it expires while the task is exiting in do_task_dead()?

When a constrained task returns to SCHED_DEADLINE while inactive_task_timer=
()
is restarting (so dl_non_contending is 0 and inactive_timer remains queued
until dl_next_period(dl_se)) and then exits without blocking first,
do_task_dead() sets p->__state =3D TASK_DEAD before __schedule() acquires t=
he
rq lock:

CPU0                                  CPU1
do_task_dead()
  set_special_state(TASK_DEAD)
                                      inactive_task_timer()
                                        /* p->__state =3D=3D TASK_DEAD,
                                         * dl_non_contending =3D=3D 0 */
                                        dl_task_release_bw(p)
                                        __dl_clear_params(dl_se)
  __schedule()
    dequeue_task_dl()
      task_non_contending()
        if (dl_se->dl_runtime =3D=3D 0)
          return;  <-- skips sub_running_bw() and sub_rq_bw()

Because dl_se->dl_non_contending is 0, inactive_task_timer() skips
sub_running_bw() and sub_rq_bw(), but still calls __dl_clear_params(dl_se),
zeroing dl_runtime, dl_bw, and dl_bw_oncpu while the task is still on the
runqueue.  The final dequeue in __schedule() then sees dl_runtime =3D=3D 0 =
and
returns early, permanently leaking the task's running_bw and this_bw on
that runqueue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D26
