Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008769;
	b=swMkD6aNjhM/IZO2oCRPnl0lOAFmp79Zky+5Pu7wRINWM1QTAD9hOK3kZkg7S/lsqtPH
	 CeW5Ytv+B4CFKQ5riLEz8kUDlJEackfp2F7TbzCgjKHtt+Tlz/wWyaCBZ20gQLu4apat4
	 lMV5fEkAjlNq7Zm7Uvtc4LCGiRtcpPfQ4xqEBT7AFJFJo3/rfPvh4hwvNe9P1Rv5uxR96
	 pUhH9kaeFtQX5sUWDb4OA+G2C8IKhQhZy9W8gHNgf/PWlt04fCgYcMQicbsC16Nob5QCm
	 0olHnVGrygvBuMaQaVtJGyIOTOvJbHXhoiWc2k2jFyAC31XWIKRo9bGMCfZr5iIjVkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008769;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P5O3bIMA8niIU8uNgsYdMxQzL+EPdl0GXXhQhteX0V8=;
	b=4WgRfsuGR3ZNbbFuX+PUKy8AiFRw65GfcnLWztwQxNJ3aaGZ8K4ijJLaOKZDbJRHeJ3i
	 5XFEtXJqh+nUWXushwyBL2ec14YkxeXNVbYzQ/qxx0RD7igh//6SbYdkuwXSAPbzXmclw
	 pJgKl1OUrutqnSDpMOjtqjX08O9EZH/CpdohYrIqmy6Dk6eNW+fWyt1KAWk9lvHNvesVE
	 dITONb2VaGvwQaNEuWlcFKS0UMdZ3ktrAI83O31VIONm/tsmw8qD2YDZZTWM2A6MJeYhI
	 dV7XU8X3b3DBKqsiOBQoIMi9rdNVhAykEcWFhsCNZZQIj/m/o98BKZdKp/BZ0P1wxyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZnKrMYX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24C606A31A;
	Mon, 26 Oct 2026 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZnKrMYX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73E81F01825;
	Mon, 26 Oct 2026 09:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008769;
	bh=P5O3bIMA8niIU8uNgsYdMxQzL+EPdl0GXXhQhteX0V8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aZnKrMYX06AvKDByfFq/KMHbyZ77EWds7MaRkbDoqwUrvInW5oxj9OwFj4vG1FC/+
	 6NaGBli+tJlJ+ratR4by8qGeOMvagakRvg3lVY2lA4NjWRMzA3lj3I1LdYurWmJkN4
	 8Z7vET79kX3yb3S2xi0Yt83GH77OTmKOuEMcFu3039xFAfj4H4BvPZxfOdDkS63kK+
	 0fpuWR3sg0Xa6i2zDLIh4c7L2OoprnxEH42lfqDW9MYeCzMTbesNNQmrOTfLdHqBem
	 syZviD2PPHb6ukQ48ANmjfZBvxY9Sc2lO0t8lfNHvglBnFKhmxhKW0Aq3zDcsBXVRV
	 ba9mb2KU+Kulw==
Message-ID: <sashiko-outbox-184858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] clocksource/drivers/nxp-stm: Increase min_delta to
 20us for PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Enric Balletbo i Serra" <eballetb@redhat.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261026-nxp-stm-fixes-v1-3-20a64a4ea454@redhat.com>
References: <20261026-nxp-stm-fixes-v1-0-20a64a4ea454@redhat.com>
 <20261026-nxp-stm-fixes-v1-3-20a64a4ea454@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:59:28 +0000
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
- [Medium] clocksource/drivers/nxp-stm: overshoot check runs before enablin=
g comparator
--

commit 1dea5edcdc7544abe47a47e00f3d79d5b290fb1a
Author: Enric Balletbo i Serra <eballetb@redhat.com>

clocksource/drivers/nxp-stm: Increase min_delta to 20us for PREEMPT_RT

This commit increases the clockevent min_delta from 2us to 20us in
nxp_stm_clockevent_starting_cpu() to avoid counter overshoot under bus
contention on PREEMPT_RT kernels.

>     clocksource/drivers/nxp-stm: Increase min_delta to 20us for PREEMPT_RT
>    =20
>     Under bus contention on PREEMPT_RT kernels, the 2us min_delta is too
>     small and the counter can advance past the programmed comparator value
>     before the overshoot check runs. While the -ETIME fallback handles th=
is
>     case, repeated retries add latency. Increase min_delta to 20us to red=
uce
>     collision probability.
>    =20
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>

> diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/ti=
mer-nxp-stm.c
> index ed7662a4e2bc4..a0761d7f8b013 100644
> --- a/drivers/clocksource/timer-nxp-stm.c
> +++ b/drivers/clocksource/timer-nxp-stm.c
> @@ -335,14 +335,14 @@ static int nxp_stm_clockevent_starting_cpu(unsigned=
 int cpu)
>  	/*
>  	 * The timings measurement show reading the counter register
>  	 * and writing to the comparator register takes as a maximum
> -	 * value 1100 ns at 133MHz rate frequency. The timer must be
> -	 * set above this value and to be secure we set the minimum
> -	 * value equal to 2000ns, so 2us.
> +	 * value 1100 ns at 133MHz rate frequency. However, under bus
> +	 * contention on PREEMPT_RT, 2us is too small and causes missed
> +	 * matches resulting in 32s wraparounds. Increase to 20us.
>  	 *
> -	 * minimum ticks =3D (rate / MICRO) * 2
> +	 * minimum ticks =3D (rate / MICRO) * 20
>  	 */
>  	clockevents_config_and_register(&stm_timer->ced, stm_timer->rate,
> -					(stm_timer->rate / MICRO) * 2, 0x7FFFFFFFU);
> +					(stm_timer->rate / MICRO) * 20, 0x7FFFFFFFU);

[Severity: Medium]
The commit message states that the -ETIME fallback handles counter
overshoot and that increasing min_delta to 20us only reduces retry
latency, whereas the comment added in nxp_stm_clockevent_starting_cpu()
states that 2us causes missed matches resulting in 32s wraparounds.

Looking at nxp_stm_clockevent_set_next_event() in
drivers/clocksource/timer-nxp-stm.c:

static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct cl=
ock_event_device *ced)
{
	struct stm_timer *stm_timer =3D ced_to_stm(ced);
	u32 val, now;

	nxp_stm_clockevent_disable(stm_timer);

	stm_timer->delta =3D delta;

	val =3D nxp_stm_clockevent_read_counter(stm_timer) + delta;

	writel(val, STM_CMP0(stm_timer->base));
	...
	now =3D nxp_stm_clockevent_read_counter(stm_timer);
	if ((int)(val - now) <=3D 0)
		return -ETIME;

	nxp_stm_clockevent_enable(stm_timer);

	return 0;
}

nxp_stm_clockevent_disable() clears STM_CCR_CEN in STM_CCR0, so no
hardware comparator match can occur until nxp_stm_clockevent_enable()
writes STM_CCR_CEN back to STM_CCR0.

Because now is read and checked against val before calling
nxp_stm_clockevent_enable(), if now is sampled just before val, can the
counter reach and pass val while the STM_CCR0 enable write is still in
flight under bus contention, missing the hardware match while
nxp_stm_clockevent_set_next_event() returns 0 and causing the 32.2s
wraparound?

Should nxp_stm_clockevent_set_next_event() enable the comparator channel
before reading now for the overshoot check (and disable it again if
returning -ETIME) so that the -ETIME check covers the channel-enable
write latency as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-nxp-stm-fi=
xes-v1-0-20a64a4ea454@redhat.com?part=3D3
