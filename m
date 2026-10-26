Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007880;
	b=5kYTFvbfKJw50AaQKTBxeEQE24Fj7MDP4Nwfbi2JbuhtS189wFAgi2jubM4WXOLvfImH
	 MUE1WXzJtmO13XK3vEfdcFSsLialD3J9Qtz5sehuITCvgalt6hQ4OKWqhSGVuVpGMCrV1
	 oGHM8ApFMGxF0wg3CpCRYgluPyeSR6sBjkPdu3ewWNoV8vOl7jVLPevJp2AzF0QWTXNW9
	 Gb845PfIKjlRl3QO4bz9+1qHR0ohIxsW+/PiqE3HU7N2tki+AclBKCcLMpG+898o2PMtv
	 bBZ31DKp6MCSb+TAj4dnJSUn6zPG0MU0t24h7mjA55QqIzB0R6JVfkgIQxuZx9sovYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007880;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ouH7elD+tXB8LAqogI+xevrlgTvhoMe5/2JANL6xi8Q=;
	b=MCVDwv2jJK0YvwlO19psaVXwpxY2oHByYAWGAbqiuvrLsLdfX46oBMUew+hPn/vNkPDv
	 qw9esUHa91kIBiWmunaEvS/iriy/lFWlH4jSOoyQmkZDcs3QmLxwruAKhTDB7pvdBMOnv
	 RZDql9juPDhKNKihrKtwHXeW06jljggMipi3U744TWc2IqgWJ/JBQWgNvK8GWPfp05IWd
	 Sj3Sq66z76eF+/KbsWM5YAHAkmpgY/oxjksUG/q4Uchrc8r4zeLnWyimVRPQoWiwypmNR
	 Oa/jRUK8JfyOIJvbJaMt7DiSyyMynz46Z5jIZYEnexQjcQ6WzJqkHEZmQRelb0Jbb6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdGgZToe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FA60A2606;
	Mon, 26 Oct 2026 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NdGgZToe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67F81F031E6;
	Mon, 26 Oct 2026 09:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007879;
	bh=ouH7elD+tXB8LAqogI+xevrlgTvhoMe5/2JANL6xi8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NdGgZToeK6jIg8FTtLUHtsV1/8m7bIMzE2XnbrvtFgiJ08Or5XCLYkeNci5Bv4ztU
	 pzK1APGZT+TXXwJ9Qlgn820ROna4M2tCOxQW4L9JIdCkPv8zCY6cdO/UQ4wwyx5JvK
	 j7I56hTR5+0aSmdk9UpcVcs2rrhYlZaqj5B5LNuNwFsskTv10UNzSinbZqMNTZeNzu
	 kkvWE9Bx09gWbP96QB+GbeeFWYAdORVkDqzqhHty6yJO4BEa/PABU9ks10UiuZSVVy
	 W+Z6kjLOndlMzZTVjvgB9o20yKW1BFbWTgIK3DLCgUDT2/4lSiGSMqmnwqGO7MWbF7
	 mKsjfFKeLQtOQ==
Message-ID: <sashiko-outbox-184830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] clocksource/drivers/nxp-stm: Fix missed comparator
 match in set_next_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Enric Balletbo i Serra" <eballetb@redhat.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261026-nxp-stm-fixes-v1-2-20a64a4ea454@redhat.com>
References: <20261026-nxp-stm-fixes-v1-0-20a64a4ea454@redhat.com>
 <20261026-nxp-stm-fixes-v1-2-20a64a4ea454@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:44:39 +0000
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
- [High] clocksource: nxp-stm: overshoot race in nxp_stm_clockevent_set_nex=
t_event()
--

commit 45f273b782a28cec6ef30880d738a9cb690edce9
Author: Enric Balletbo i Serra <eballetb@redhat.com>

clocksource/drivers/nxp-stm: Fix missed comparator match in set_next_event

This patch fixes the overshoot check in nxp_stm_clockevent_set_next_event()
by using a signed comparison between the target comparator value and the
current counter value to avoid missed matches and 32-bit wraparound stalls.

> diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/ti=
mer-nxp-stm.c
> index ee249fed1b918..ed7662a4e2bc4 100644
> --- a/drivers/clocksource/timer-nxp-stm.c
> +++ b/drivers/clocksource/timer-nxp-stm.c
> @@ -247,7 +247,7 @@ static int nxp_stm_clockevent_shutdown(struct clock_e=
vent_device *ced)
>  static int nxp_stm_clockevent_set_next_event(unsigned long delta, struct=
 clock_event_device *ced)
>  {
>  	struct stm_timer *stm_timer =3D ced_to_stm(ced);
> -	u32 val;
> +	u32 val, now;
> =20
>  	nxp_stm_clockevent_disable(stm_timer);
> =20
> @@ -258,16 +258,12 @@ static int nxp_stm_clockevent_set_next_event(unsign=
ed long delta, struct clock_e
>  	writel(val, STM_CMP0(stm_timer->base));
> =20
>  	/*
> -	 * The counter is shared across the channels and can not be
> -	 * stopped while we are setting the next event. If the delta
> -	 * is very small it is possible the counter increases above
> -	 * the computed 'val'. The min_delta value specified when
> -	 * registering the clockevent will prevent that. The second
> -	 * case is if the counter wraps while we compute the 'val' and
> -	 * before writing the comparator register. We read the counter,
> -	 * check if we are back in time and abort the timer with -ETIME.
> +	 * If the counter reached or passed 'val' during or before the
> +	 * write to the comparator, the hardware match will be missed,
> +	 * resulting in a full 32-bit (32.2s) wraparound lockup.
>  	 */
> -	if (val > nxp_stm_clockevent_read_counter(stm_timer) + delta)
> +	now =3D nxp_stm_clockevent_read_counter(stm_timer);
> +	if ((int)(val - now) <=3D 0)
>  		return -ETIME;
> =20
>  	nxp_stm_clockevent_enable(stm_timer);

[Severity: High]
Can the counter still advance past val before nxp_stm_clockevent_enable()
arms the channel comparator in drivers/clocksource/timer-nxp-stm.c?

At the beginning of nxp_stm_clockevent_set_next_event(), channel 0 is
disabled before programming STM_CMP0:

	nxp_stm_clockevent_disable(stm_timer);
	...
	val =3D nxp_stm_clockevent_read_counter(stm_timer) + delta;
	writel(val, STM_CMP0(stm_timer->base));

Unlike timer-imx-gpt where the compare interrupt remains enabled while
writing TCMP, writing STM_CMP0 in the NXP STM does not arm the comparator
until nxp_stm_clockevent_enable() writes STM_CCR_CEN to STM_CCR0.

Because now is read from STM_CNT before nxp_stm_clockevent_enable() is
called, if now is sampled just below val (so (int)(val - now) <=3D 0 is fal=
se)
and STM_CNT reaches or passes val before the subsequent write to STM_CCR0
takes effect in hardware, the match occurs while channel 0 is still disabled
and is missed.

Should nxp_stm_clockevent_enable(stm_timer) be called before reading now for
the overshoot check, with nxp_stm_clockevent_disable(stm_timer) called on
the -ETIME path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-nxp-stm-fi=
xes-v1-0-20a64a4ea454@redhat.com?part=3D2
