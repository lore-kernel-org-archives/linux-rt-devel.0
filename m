Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654733;
	b=Sw6ZEeJcSrnzF5WQo2z3OI2Bum/QWUZodc0mtEuzu3iSzgq6eUbEfOhzCiI93FUs7qbv
	 S/C5yi/q6vtI7ToNj2xPOio/RJ9U1LP/Hx9of++kmNFDYJUSINeiYd5clA0C7QVPCgsVC
	 oosZTholhxDvE28Hweki8Dlj4C4EzP93uLY9XvrWTQTTTHmxCsNqy7Z4GzzHj2ghXjAB+
	 ZTN4RVMg3dvfOiZxfmHUMzgqseq+ZljoDrO4dgxwf5XuYpYNbcgXaRShcC/PMDB20/StQ
	 fqYmzhYKeKdnckNb7FEWpsv8reN612cnHv5j0jw6aKtRK3+YbAQtuI1ClMTZiidtQPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654733;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Dyy/30Sdte4Ve02aKSe0PVid2WxXxrenmHRYm4WhPxs=;
	b=guJBL9cESvtaFAmafPLJqtkS/QVCMY3sGDxUHN8Y/EHXSD3j030S5lYv68luAolAN7H4
	 BvXTKD9q7o6TzV0tXS3aqzf8niwbZoFHq7JoV/7djE8Y0Ki2IDAAl1MAWCJcpdRpPdDtN
	 sn6Iq0c/ltaR9TPaqCgJ12lpkKUYMHjcgEyv7OX4mCNfHTGRReASsjLkHwf+hGGjWwPMK
	 FANB7mAhPGpXIjG6z3+/awKgrEiJyPl1cjcFbjO1noMNl5usCFqRR77MlbYoJouGyTqE3
	 ja7yIV0P4SpgWaHkcq/HR/SUTEXPrYnCJUUY7PWKyinRf9VhMd35+tE75ifrmCKwbbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+xOe4S1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00507606A324;
	Mon,  2 Nov 2026 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+xOe4S1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0FB1F00A16;
	Mon,  2 Nov 2026 21:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654732;
	bh=Dyy/30Sdte4Ve02aKSe0PVid2WxXxrenmHRYm4WhPxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X+xOe4S1AsAERmo19WXI2Dq0vsaonKu3bG5wI/cDeYtfUt0aHsxckUzUeSDuY81t1
	 1PFQCNlgKgaVyK9b1Kr/eLhL/wO1NzjJh9zlmdI7qqDxgZRdZbMCse2akcbhXtejnK
	 OXhq/wdSLOtym2MpTi0hsLUYBowpqEH8uXydiD2gKktxi8GkJDId8MxW/9iobD/rVh
	 fYI/H0RoZRZwQInFNcflHNCT5NjZilztbB3YNCTnrYYpu1PXewcUKptO7X6ehNWZY3
	 GOqpwFScoId3ldJ7YAIOMwMxge9tjPl0AGkWWzehNM05Az1gkk8oYEyx1KPuDqIAyx
	 Id6XCG5zkMp2Q==
Message-ID: <sashiko-outbox-194195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] clocksource/drivers/nxp-stm: Increase min_delta
 to 20us for PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Enric Balletbo i Serra" <eballetb@redhat.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261102-nxp-stm-fixes-v2-3-8ca2706f30ef@redhat.com>
References: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
 <20261102-nxp-stm-fixes-v2-3-8ca2706f30ef@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 21:25:31 +0000
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
- [Medium] clocksource/drivers/nxp-stm: overshoot check precedes channel en=
able
--

commit 1283cc4078852e277605e923b00287b73e75d175
Author: Enric Balletbo i Serra <eballetb@redhat.com>

clocksource/drivers/nxp-stm: Increase min_delta to 20us for PREEMPT_RT

This commit increases the clockevent min_delta from 2us to 20us in
nxp_stm_clockevent_starting_cpu() to prevent 32-second timer wraparound
lockups under heavy bus contention on PREEMPT_RT kernels.

> diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/ti=
mer-nxp-stm.c
> index ed7662a4e2bc4..a1a0e23d33426 100644
> --- a/drivers/clocksource/timer-nxp-stm.c
> +++ b/drivers/clocksource/timer-nxp-stm.c
> @@ -335,14 +335,18 @@ static int nxp_stm_clockevent_starting_cpu(unsigned=
 int cpu)
>  	/*
>  	 * The timings measurement show reading the counter register
>  	 * and writing to the comparator register takes as a maximum
> -	 * value 1100 ns at 133MHz rate frequency. The timer must be
> -	 * set above this value and to be secure we set the minimum
> -	 * value equal to 2000ns, so 2us.
> +	 * value 1100 ns at 133MHz rate frequency. However, under heavy
> +	 * bus contention on PREEMPT_RT, 2us is too tight and can allow
> +	 * the counter to pass the match value before the channel-enable
> +	 * write takes effect, leading to 32s wraparounds.
>  	 *
> -	 * minimum ticks =3D (rate / MICRO) * 2
> +	 * Increase to 20us to guarantee the comparator channel is fully
> +	 * enabled before the match value is reached.
> +	 *
> +	 * minimum ticks =3D (rate / MICRO) * 20
>  	 */
>  	clockevents_config_and_register(&stm_timer->ced, stm_timer->rate,
> -					(stm_timer->rate / MICRO) * 2, 0x7FFFFFFFU);
> +					(stm_timer->rate / MICRO) * 20, 0x7FFFFFFFU);

[Severity: Medium]
As reported by Sashiko on v1 [1], does increasing min_delta to 20us in
nxp_stm_clockevent_starting_cpu() actually guarantee that the comparator
channel is enabled before the match value is reached?

Looking at drivers/clocksource/timer-nxp-stm.c:

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

nxp_stm_clockevent_disable() clears STM_CCR_CEN in STM_CCR0, and the
hardware only generates a match event when STM_CNT equals STM_CMP0 while
STM_CCR0[CEN] is enabled. Because nxp_stm_clockevent_enable() is called
after reading now and checking (int)(val - now) <=3D 0, the latency of writ=
ing
STM_CCR_CEN to STM_CCR0 is not covered by the -ETIME overshoot check.

For any programmed delta (20us or larger), if bus contention, an NMI, or
hypervisor/firmware delay between the two counter reads leaves val - now as
a small positive number of ticks, the overshoot check passes while the
channel is still disabled, and STM_CNT can pass val before the subsequent
nxp_stm_clockevent_enable() write takes effect in hardware.

Should nxp_stm_clockevent_set_next_event() enable the comparator channel
before reading now for the overshoot check (and call
nxp_stm_clockevent_disable() if (int)(val - now) <=3D 0 before returning
-ETIME) so the counter read is ordered after the STM_CCR0 write on the bus?

[1] https://lore.kernel.org/r/20261026-nxp-stm-fixes-v1-3-20a64a4ea454@redh=
at.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-nxp-stm-fi=
xes-v2-0-8ca2706f30ef@redhat.com?part=3D3
