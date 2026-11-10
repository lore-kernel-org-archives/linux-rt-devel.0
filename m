Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794298047;
	b=nNSwc/jRnWIxPfvwn+S811a5IYGegPAiYlChM9bbZSBfwSrf4X2rrM3mhawjBxLcZ7oN
	 0crZvmKof2QKEBeGOxd5TZojR8/bhbuTgL7OMIiJhhCy0tMNURZTQmNSC/m86ELzWgI8Z
	 Zp/TQjT3iMzGWP4eZN4wwSWijKpG+UO8GO2H6MEgM2eUwWz7zPgVlBn6bxQD3/ygsk9jB
	 RVQStkfxe0sCumzgLagrrGq4bjcuYhq6xXMmXbDcBczILvAADcUqLiYh/SkDzUB5uCgAl
	 jcuS/q+7t4F4D6vxcj1L/8JXB3RWgjVC0+cl/FEubrAwj64YlMBfqjqvmRm/hmbCoeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zKy/gJ2Q4OqB/ldZ+D1suUF3Ao+MCf7ZUxfe/sFiu9Y=;
	b=mzs9PcFLvO8KK0zFJ0RtbBwPN2PRGf8YT1WfPlT8gCO/o0i4PyBpbpqAb6e+unFMvcBI
	 5SIRFSC9AGfYbYykjrOwt9jA34sbN1yUScUVW0EQLalGkLtKpbw7/SQavVP21cfGAM4VB
	 2NJdDT5L1scX2M9euXbMR6Fx5xs4HDyEEZcPhxae7Tm4hukGigrWZwGjajsQG7Y1W0fre
	 2iC32iJfJBFsHKbGdB8zja7L92SR9syrR5MQaEAl1yZOL9fVmP0n2G2jq09ukoMGBqosU
	 tT0EuaZKM214LEM+Docd2pTMuwJcnTnjOjYOpywOCjdZgG5FOmRqe8MnrYltamABS7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=k+pNwPnH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23C606A31C
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 08:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D23C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=k+pNwPnH
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490a0e72588so880164f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 00:07:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794298046; cv=none;
        d=google.com; s=arc-20260327;
        b=IhmjrO0YOdotp9o5Qy0H1glrzNxazLLCWo/vgae4/UHuTgsIJcFGNxd/eWYG6FaxeM
         6Ox+3Nt2HqFabuA6PuBWj9WcOMYQusZCMKughT2YUZb49EpDYQjQMJFqatLmISFsTFJp
         p0SohejCAQAKWrka6oSswd8iCtmukyttRzv4ybv+uSAW+LgAZMeH3DT1CkTyeIs9CfC1
         1COIjS/zjmeb/LmULWwjLQqW1WdErc/mCva9Xw7p2ExtBzjje7qAQKaAi8akWzA6gsIB
         QRxD6GxyzRP44TiqYkFbb80sitrZOh89/s8XKUZZuWqIYH4iH7aDbssku168+5PvTmVb
         igdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zKy/gJ2Q4OqB/ldZ+D1suUF3Ao+MCf7ZUxfe/sFiu9Y=;
        fh=3tqu8Bxa6OTSnqBKIujys3PmFA5JzcSyPOUh0Zeg8og=;
        b=VbNWdVwnleDVSiH3ghwJx5RYP+ygIp8pBHAyZuyV6RLk/BrVfOmi7P2QtSP6bwzCoh
         BS1jgBHYz1/9e/gPzj1Spn0/O11FMkZ0ucHmkP7dzu6lXI/CmGciqjLJs39LivxkA6FJ
         MKq5a+ZxFtmrdmzHQgg648vO9R3mr++8spngby0XSAeB0CE1xTeI6OloZ+QVEjRhISG1
         X8k+akFLhq/TZEBopHESS5jCTuu9SQgduN1gow2HE9ZuNFF3VbhX5nO7+lns9XeD/XxP
         bcHc3jEoPKc8jwtOfvnCBEGqCnaWs6NQwkZZw1D/ht+sgNXP2flNn3gYvTgk2005Cks/
         EWuw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794298046; x=1794902846; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zKy/gJ2Q4OqB/ldZ+D1suUF3Ao+MCf7ZUxfe/sFiu9Y=;
        b=k+pNwPnHRQ/LMFqUE9HBi7TKG7pY/+sTwtvkUSgRKcfqq79uObmMVdDQUtbpDDEAPy
         EO+kGorqAw6D/2M2IH2axyRWTriIOGg37SChvHYDO1DJxmrYlt83obGgaoUK1HiKGKel
         IlwMUEcaQNSAzJUPT/pvilKFjc4N951ookc3ZsUx5SCpbg8dKCZUzMdsRuc88VfJpc3y
         TFgJS3rqoTkKvEHdgkLgE8psHRTuH5hnK259OFvUeKobV9a7bvNQ35m0HLuFxS7FN6SU
         LVo/UKkFeQVgFHRhokp1eAka4I6EdS6Qp2RRej9bStp8R7L0ZEsXtIHalHYTBm5bIJ+U
         JQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794298046; x=1794902846;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zKy/gJ2Q4OqB/ldZ+D1suUF3Ao+MCf7ZUxfe/sFiu9Y=;
        b=dsWtpVbbYeAZvuBf0V5duwuJZi2J3UssgPJsX7Q5Ne3taAfhjUNZWU+Y2xyUg5cPVG
         V0VgkkPdEyKJX/z840X5/w/s3tqlEdckcyMlmY81wfArXapWgUIoYQJehrQYodK4NH0t
         ay+SexqBEIWruwBD5EfKUHhFbxcsVeDaFJV+ESFSlU8Zdmw9MgBfy7dQe0XhRwsnirZu
         k4RlITNe8hwdzspVuJncqQTh2OnjWcp411a6JlVcD+LBfryFQ6t8g888jr/svEAt2zPV
         5w3eNYaKRbca75GR6RnwoD3fDGAtHkUtsQ8nfrBRK4+Bgyp8ElH6sgifjGR1ZJkqrtr/
         yBfQ==
X-Forwarded-Encrypted: i=1; AL+hErHOXSxVFG+bFyaK8OdiTtz8S23iWJYVQ/4CEtldPyzKKOxmoxeeZL+ccLEFjcmayD0b+eU8W6dvKonXZC8Hww==@lists.linux.dev
X-Gm-Message-State: APuU4Z/l9EVPWaVI1Y+IC7iVoZDjoUTfKDtc8jeR3bJt7JdmcK5DjpEE
	iNplVxVRgBxtBR2ges9kgLeAvh+pDAnYXedN0pP/Spzjq9vtoQP2eb7IFD1TcfyVpNiNauu8gKl
	hB3oyVu87uiy+elMNejXWF2gQRFSNQpoEzN1KfPTvnQ==
X-Gm-Gg: AYBFou2Qo39gqa9cQaSO/aR+JL5dWOA2i83GhNwaDc0jqr6mceVhjyBmC9MKDeG4BmI
	2Fvs1RR8I7Z4VXOxecaFaffwVqrJJBK11BLsoXRlNRJbJNvEkELJHR95FBR/b4euh1EM/BjuWkP
	YZN6mzSh9ay0hx4Lv7q9ILD9B5US48Dbw/kSScHW7ahchoVdIGkIqSx8nhi3pC8GjQOZlwt1jxc
	NRt9WepDk7TM8H5IpPH3uqNR6+Keotnw5AFZ6ObbLPWImg21A84jo3JBWwtCplErbwdecVfmqPV
	mhPYfWBTuCDYGuU08Q8QPIymMeVPJG2yAHlSkjmazRKEtS/1LWXMDiLV5OfAsPtlaLMvQFbuVHB
	Zie5bXgIIReywkLCZjnLKDyPdPspFB97uuffSCSJfb71dE7RbyDoOvDWh04ZeN0PwlOV31zYWvg
	qgrB9MBa+RYvK7XaOYxa/jFYtq5mDohcxWxrtrByLnBUeUBJ6V9uk9iTE=
X-Received: by 2002:a05:6000:290d:b0:48c:7386:af18 with SMTP id
 ffacd0b85a97d-4982b28aa0cmr3447294f8f.8.1794298045549; Tue, 10 Nov 2026
 00:07:25 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261020-aplic-async-probe-v5-0-c4861c2aafca@mobileye.com> <20261020-aplic-async-probe-v5-2-c4861c2aafca@mobileye.com>
In-Reply-To: <20261020-aplic-async-probe-v5-2-c4861c2aafca@mobileye.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 10 Nov 2026 13:37:14 +0530
X-Gm-Features: AclHuK-vBDH2XlztsVwt_XXQdD8zuFsijRvxMQGcBNFnVvFsuvB6NPhtCgNa4gw
Message-ID: <CAAhSdy2kxydOk9wPdBtVHCTN2uDrpFbQ0WGUXHz0AUvUWAncpg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] irqchip/riscv-aplic: force synchronous probing
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Jessica Liu <liu.xuemei1@zte.com.cn>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 9:09=E2=80=AFPM Vladimir Kondratiev
<vladimir.kondratiev@mobileye.com> wrote:
>
> The APLIC driver leaves probe_type unset, so it follows
> PROBE_DEFAULT_STRATEGY and is probed asynchronously when the command line
> requests it (driver_async_probe=3D). The probe of an APLIC instance updat=
es
> state shared by all instances without any locking:
>
> - the check-then-set of aplic_syscore_registered; two instances can both
>   observe it as false and both call register_syscore(), inserting the sam=
e
>   list node twice and tripping CHECK_DATA_CORRUPTION ("list_add double
>   add") in __list_add_valid_or_report();
> - the global aplics list, modified by aplic_pm_add()/aplic_pm_remove();
> - aplic_direct_parent_irq, where more than one instance can pass the chec=
k
>   and register its own CPU hotplug state;
>
> Interrupt controllers are required early and have no benefit from
> parallel probing, so rather than adding locks around each of them mark th=
e
> driver PROBE_FORCE_SYNCHRONOUS. Probes then run one after another from
> driver registration, and deferred probe retries are serialized by the
> single deferred probe work item, so the shared state is never accessed
> concurrently. Probing is also blocked across suspend, so it cannot overla=
p
> with the syscore callbacks either.
>
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> ---
>  drivers/irqchip/irq-riscv-aplic-main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq=
-riscv-aplic-main.c
> index 5369078f3d00..3c10dbf3b492 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -118,7 +118,8 @@ static struct syscore aplic_syscore =3D {
>
>  /*
>   * Not __ro_after_init: probe can be deferred (e.g. MSI mode waiting for=
 the
> - * IMSIC) and complete after the init memory is made read-only.
> + * IMSIC) and complete after the init memory is made read-only. Probing =
is
> + * synchronous (see aplic_driver), so no further serialization is needed=
.
>   */
>  static bool aplic_syscore_registered;
>
> @@ -413,6 +414,12 @@ static struct platform_driver aplic_driver =3D {
>                 .name           =3D "riscv-aplic",
>                 .of_match_table =3D aplic_match,
>                 .acpi_match_table =3D ACPI_PTR(aplic_acpi_match),
> +               /*
> +                * Probes of multiple APLIC instances share global state =
(the
> +                * syscore registration and the parent interrupt of the
> +                * direct mode) and must not run concurrently.
> +                */
> +               .probe_type     =3D PROBE_FORCE_SYNCHRONOUS,

Making the whole driver synchronously probe is a conservative work-around.

Your original direction was good. How about the following:
1) Convert aplic_syscore_registered as atomic variable
2) Add another atomic variable aplic_direct_parent_irq_count and use
"if (!atomic_inc_return(&aplic_direct_parent_irq_count) && domain) {"
in aplic_direct_setup().

Regards,
Anup
