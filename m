Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8032361679
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Apr 2026 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719127; cv=pass; b=oz8IY3HlD6UZ9aIFhHz68eV0HrvSFqrsJLV+oJa4+2dpLeb3yApJS4ery/8tm2bczMHLQqFzkcn31kKpBnNLFnFV08D0m8hHDQNusJroMMPOe6mfoYciPILseWEnVY4T3i3wmzUSi38jf/EVcLZB00NgqAvuNBWplSJLTSUy29A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719127; c=relaxed/simple;
	bh=V33fbzj5xTzbEm7yrIuyKhbRc0gQ0rmNSx5Wh14vJ10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5TZJo5HN54uWXgAR+giIrBefenJ27zfu6/zk2ZDmujrDfHhWw8ZnarhChhiktffwEZLKwW7iQfbk1bxFrBD/eM21rb9vMgyk2kPQ/Alni0J32lcDSRuAvBRjiDQL7eus6yT3BxdDyzhjQ78LgKDwp4sHunSfnIWR2/+oaNEzBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LdjqlRo+; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdjqlRo+"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d8da3e656so6021301cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Apr 2026 00:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775719125; cv=none;
        d=google.com; s=arc-20240605;
        b=PaWYrjM8EUgUUCK20LxSGyOPbAy2YDJlYp+3etLye92jdz99vgbFisAORd1rKLNsiS
         W+kz7v3/toO2dsZD73fhPH5ywCEenum1WQi4AihoTFC19H7C9KOrBzwRYiqs2HtFav5S
         F/At/yRAkQ9GE6D7iFeJQA/8BiqhAIJVplu5l/xwKP1/wnNsd4LBS1ZxMZf2K/Mtb1rg
         shVJSIVDl70LRrtHx63ECEEMKbkf/9soO05Ylf+rUc5l2vmyZh4Xp6jzrkjvGHf7EmZw
         1fBWSHWUAtghMuyR8U8PN3nN1tJCl0VykB7lggIpgBJNayDArRqAuHf4EdHMW/XwE6iS
         VVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MHX63UpbuJfkt8TSz+vhS1tQGY0W/7drntvhqjvQ2cQ=;
        fh=RZb2M5YNl4CfBM4p12zZMf+9VEdgrQtHu2qtlDDzuzs=;
        b=WNarnOC4QovRu4GgM53+xxmPrRW+XSGpoRiXv5IYPajudvxC4WyMKgRJlHDkJoqDH3
         4Ns4z9AlIrV33nbOe/AH4Kz7jUgkBlcWkMF6+5EPyNRHp4MiZNUz9TADu79mYTE6mA75
         nyzojaBnzL57QHsG/OP9TUYxi5ozd8dCyAKVJv84PeEvLZZOla5JkL1OZxFCefDL5qed
         qLhRzJfjVcqjsqTnw1DtIpOT0dBmYyGEFVIU56vMcNs+oehfAmrmwywNByWQ21liF/3K
         /NWKAZ0FpjdyQb0yMm2CsFLXeSwEAWlqtaKYFFQQa6f4rC1o9uWi9bY6e8mqwZ943T9y
         YUDA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775719125; x=1776323925; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHX63UpbuJfkt8TSz+vhS1tQGY0W/7drntvhqjvQ2cQ=;
        b=LdjqlRo+iVHWWTTRnj5xa4sHX90wQILQvScc9sNqVMcChyXRMAQPMcQCBRfUMW+skV
         T6CIQQZ09r6oEHMD13rlkBeFQRfZTGf65EsHKxEx1cFomeZWsW2d87xUlCGmIi3PNuNz
         f8J4wu2+R4sccSstdbjumWaxsX1/5t++DBCDzLc5/WWAe+vCfmPTW9hkj4+FS5yyyj71
         9DhW+neRcaJsCGh0wbVcT6bco6Hz5yHl4oY5nEswCp2OKdmdF9BWgDWhwO00KkEM5uBy
         8ytMvu6tzYAi3OB21nV8qVSxllXwtITZu0GG5cCeDn8mPEV1p9yZecS+1oV0pNgSSt8t
         AaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775719125; x=1776323925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MHX63UpbuJfkt8TSz+vhS1tQGY0W/7drntvhqjvQ2cQ=;
        b=QlZ6ny8WD8/4F2SeKMOgXK5Zi9jCvTgvwY+OlnDiiTIJhKOeocylIGQ+5XHcUuzoC5
         8pfPlSoXvgawggA9IA/ctm0OAx1treU7DDxDXzrcd2FyUvyo8Ktf7Bj9uy3+VbM7L7LY
         NqrmPUjL7Uejayokk0H4lThyIfdao4tXgkP0EWEL7PKVOR4+dWq3+lFaEAOl0lbR64Bc
         vtALN8iMATaBSP6zkU76WxD/XOr6iMy5Eab1RObkgSl9P8tDXTRspIh+s+6mmucr1qM2
         ygWADwgf/DBqTrvF4b/uDu8JABe1ZONC9GHnmB+0bu0eYj2FyhXKkln1XrLx9L1IJ2zh
         FeOw==
X-Forwarded-Encrypted: i=1; AJvYcCXw3hGMp0c272+NMpm15sXCYM9UBSWOjVP1VZhF44d07VhS3mrMaLhBTlyceDs5DsOosTPyYAsmo7753z3+Qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfN+RPmbBRl/AJEzqUFui7eg/eujeITi0em7lUMoqpFTVosDbp
	sBmxENC+XWagn0iVb90306OvaQf7uRMtaBvmSEmNktZFzkR7XtmvJluF/HdreIz5dl1dgo7k5jS
	nysd5WPhkAEUV4jcP6no55agm4aXAqeOnKo/7yA3T
X-Gm-Gg: AeBDieuihZELLn446Z1gftuMrMi/4oM9/OWKTNO+kBFYyfWBfDo1ya/u1L2E11yzCj7
	+1jlCoBmAXkw+AelePLatQ3fG3HNvDZY6kIpDjY3TYCRijENu2KODIXoYY6XsnTSwKPVPiwN+LX
	dslkZdsUpAdK+7OTBCcNb+m4VCcQCVJ96WmCdTJRZzkFcP63+zqHjsIpq4/jVC96zbZiIK93JOV
	onM3r1H28WW+2L7CU7OqXBAPoStAARvvPWMvi9rHYUoqY8mnT2aXKV7/7RfPMlK1uVjndW2Ctik
	x5lrsno=
X-Received: by 2002:a05:622a:550f:b0:50d:a466:6d11 with SMTP id
 d75a77b69052e-50da4667327mr141152041cf.33.1775719124336; Thu, 09 Apr 2026
 00:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260409035344.214279-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260409035344.214279-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 00:18:33 -0700
X-Gm-Features: AQROBzCBrSFz_fNky2oRmRFlJtTuudv4zSWZGQhSCskIXjdCtwr-zR2LdxvTwxU
Message-ID: <CANn89iLEpVVo=q4FPpBQ5FomoLmdrfW3su7Mb0ZES4EV9=Q4xA@mail.gmail.com>
Subject: Re: [PATCH net] net: fix __this_cpu_add() in preemptible code in dev_xmit_recursion_inc/dec
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Weiming Shi <bestswngs@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:54=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> dev_xmit_recursion_inc/dec() use __this_cpu_inc/dec() which requires
> migration to be disabled. However, some callers like SCTP's UDP
> encapsulation path invoke iptunnel_xmit() from process context without
> disabling BH or preemption:
>
>   sctp_inet_connect -> __sctp_connect -> sctp_do_sm ->
>   sctp_outq_flush -> sctp_packet_transmit -> sctp_v4_xmit ->
>   udp_tunnel_xmit_skb -> iptunnel_xmit -> dev_xmit_recursion_inc
>
> This triggers the following warning on PREEMPT(full) kernels:
>
>
> Fix this by adding migrate_disable/enable() around the __this_cpu
> operations in dev_xmit_recursion_inc/dec() to ensure the per-cpu
> variable is accessed on the same CPU throughout the inc/dec pair.
>
> Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functi=
ons")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/linux/netdevice.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 7ca01eb3f7d2..6b1cd5380d70 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3591,14 +3591,19 @@ static inline bool dev_xmit_recursion(void)
>                         XMIT_RECURSION_LIMIT);
>  }
>
> +/* Non PREEMPT_RT version: inc and dec must run on the same CPU,
> + * migrate_disable is sufficient.
> + */
>  static inline void dev_xmit_recursion_inc(void)
>  {
> +       migrate_disable();
>         __this_cpu_inc(softnet_data.xmit.recursion);
>  }
>
>  static inline void dev_xmit_recursion_dec(void)
>  {
>         __this_cpu_dec(softnet_data.xmit.recursion);
> +       migrate_enable();
>  }
>  #else
>  static inline int dev_recursion_level(void)
> --
> 2.43.0

This seems wrong.

The migrate_disable() should happen before dev_recursion_level().
