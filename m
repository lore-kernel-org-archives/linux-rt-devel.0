Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795539523;
	b=V9yK1KD00mxtf0Udl/VaBc4qbD60YSR41NoNHSxbm4Dg2KCVLlW2mzYnsGUcxV+RqK6l
	 ejmmgzw0b+Dv6WQnHziPsB5muODOShkSA6qLoiWXnv6rvWPROegusWa1iPuPPuwLyBj4V
	 8czjWCpiFnnCzKZDfgLgPJBXzokfhyFxiklm/Fq/lSdzzmos/k5Rv/efW6KjFxjnNBehD
	 +MHshsgbpg4oDztAEfCymyRRf3JdqOZbhIoFZ/KkGXzGkrJ2NrMpxCZ4VPA0pzF7rMJmm
	 BJUOhJktdhI3CCh1zdahPaBOuAv//vpbo+VQDuu5Q8+XIZYVYWYDt8PEnQ+Vy+JRTgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5HjZJAjY5u3Fowj7izRJvXnGMFA618no4HsUeAZCCbU=;
	b=eL/TYOU3vrZM5DmgI6g2bsX8gm3yvfTUuHvLf3aT8TdL9SYH1+YOaKwu3Q7K1rq1hPhK
	 doD7C/BzGs5FVupNgOlbN+ut64AK3eC9BQKG/Yu/ohiB+nANe/8bu0PU/dJB0H4UfvBKk
	 6i+5nOoO9fqfoXhM1ngaHBc0ijQaCG3eL0GRIEo6nSqsvhK13afZQ4phmlDbtjbWwCZzZ
	 A3k+AR39WwBl5w/iTLVlG/uU1aLPbR/OR8IoAiWIYRbhe9pjwTPDRGrXvQe0W6r9cFmaU
	 JOlmuNvFrxdvsoATlZj64PbjPiE2XaYU3LvuvxaQ9jFMrU88HC6ejamZdjcWJ2bWqIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="KIB/l6Ds";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE16606A323
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 16:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BE16606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KIB/l6Ds
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so1752561b3a.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 08:58:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795539521; cv=none;
        d=google.com; s=arc-20260327;
        b=RWBt3AfBEYpAokcqNu4BKVdNHerLq6Qgjse/spYG1L09zrr9Yku4PgIaPwI7bVFS1h
         ZsYm2GiI0uq1gUL/JZwfcM9xeevQPpDzAoziqk2fw/T30ikD/NvklUByY7f9KGargCGb
         +bROo3z2q/nPGb2hPv8pqmNQQ1KmyWXh2qYvKRhiSLhvpaybe/P2Xc4vlODrQ4V8T3Zt
         gTr+Dc2FljsIBTVmBpYzipWNIjKHAR5N1WrkoMBF/cexxNG1GZibc9fWsLqnGo+Ee9H/
         sxCnO4G73fPZOfzpZ4HQK3nkPCI3OluypwQQRqy13i3Kgg8vYCmp1bzcH0lUUeZey25Z
         Mklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5HjZJAjY5u3Fowj7izRJvXnGMFA618no4HsUeAZCCbU=;
        fh=DuftyXpLQj+12rLgZTF3bB625mY9m0WqaQ89yblHPOg=;
        b=XzBE3LfOX560+IPGF508oPNM//bODsybB4pkEt6g1KrMdQSwp6Z7LcnWgmRsiJchp5
         3/4jnrdCegGi5gSx6U2o3WPFmxw0AbDO4NGn/DIaE1hhwphdn4/umFNKeVWxwsOwkIdy
         sl/VtD7Wdt47Cr+yCE4pAeXX9znASG69EUNhejrrC2vA8klNg6ea85mUTYC9EqX3qZZv
         RKwacIYcjKIthW4fpFk/5Zg3OvhmactuhprtOIXDYUDOe6ot91dRcCvhWMKYxVFT6Avf
         io9h+7u1x1DmxK3eImTfYdPCDmAvVhIt37Snr3pj86K1IFAilbysJZCLlvfNQwekl1eU
         VX1w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795539521; x=1796144321; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5HjZJAjY5u3Fowj7izRJvXnGMFA618no4HsUeAZCCbU=;
        b=KIB/l6DsWGoaHtN+BpacgIADucippKeFTNGp4rvsBncslyxbwlOyRQZ/G3bKz2ydpJ
         +w3UYBp0TciQLzyPjJkTjwkj10w2GDkYA2BTNK+M85FFyewftaQHcytJ/U3esx9pmXqq
         bYvgBm3qVpeESbkQS7j8GmEx20hZ1CcRQ3Bqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795539521; x=1796144321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5HjZJAjY5u3Fowj7izRJvXnGMFA618no4HsUeAZCCbU=;
        b=WkHFXMv+9QVbmHNr5+s/aBM6Yfz6HtG3c0n6JthD8JaF76FpcIXVm0YqFlH8g5WCET
         hA+dcDE6x44PIgzBCuz/1sVdOo8g99ChG/jkRY9QRAR/hLT/lhpWtJ41t3uv6YotHqmM
         Uq0PB8ZlNy9LzdP2WPFf6+wwYBNKsK2ZoGAQ1iTpA8F6dwwNX0TNkLFr8xFQcr5xj7VI
         q3edqBe8bxOJEfbcWvhIS36ZueIs+ifP4WC2fiC7s8dFD8zxIwsAD1n8Lpv31F3bqZ+r
         FdIaVUeJjlDVNZ5xm/w0wbUuELa4MZAM5/TL7PYyn3274UyOHANb7qNNvGF4++EdDZnL
         YJ0Q==
X-Forwarded-Encrypted: i=1; AL+hErEKm/xSh3GpilIKWZ7bUMU511lFCB2k6WMxbGJjm2C/g1Y5RLzxS4/Lvfd6non9wsLIvx1RQvuF7td2DoUHMg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9OR/KFjadAP+vJBuf+hgAgdaUwcIWG1Rsz8ZluN5NYDfBBalCQ
	IFvV8VhP3ubRgAGG9YPGew0lgbZ5N2Ant8ZoChUykmjEdtgO3Mww4kLHuQTDsIqcFSoUKIgtON/
	Laq/12Sh6tAYl2ajgb4iKjnUMr1fiWtzyvW8DhKCy
X-Gm-Gg: AZFdTZdar2hxwuB/kKHptgOCyOyDbYH2b71ka6b6iTyoSpXHDAletAF8YHC1EwBtTbi
	nAHDsm0RxuhHqnsrqQWZMFEk5JQ3f6nH7J5upazsRBiP1109UcMhfoi6+V/A5a5hn0uWyDgPHiR
	0szfW13UW/YgpSdEiHFBSCglsQ1G6LN04/qJyE0hr04rICSjRvCrpolPxdv7zdaLVWpEoPaG4Ei
	5l/mB2yoRovs8AM3/Ar+qmfof3HTpS2qYtCizK08V3rrRY/YYO0Qzw+hcWVncjtTo2EIZATC05h
	j8uEpOcyPLvxX0gU2seWRzZ6yRpn8kX/BuEfPpEdQkCDrQxLXiWkpckP9nNIoIoWUMMrgZmiGQR
	Y/6PlvYI91jbuCu1WuBxp7whDrJYDm8ojWmGsCubi3J9sbmtc7rMssSwgFeY4tijD6QYCZUkWQR
	lTI8z87+jocw8SBTA=
X-Received: by 2002:a05:6a21:6116:b0:3e2:1418:aae8 with SMTP id
 adf61e73a8af0-4014dd566d2mr15911153637.72.1795539521356; Tue, 24 Nov 2026
 08:58:41 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com> <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com>
 <20261124161258.vLyrm8Y4@linutronix.de>
In-Reply-To: <20261124161258.vLyrm8Y4@linutronix.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Nov 2026 11:58:29 -0500
X-Gm-Features: Aa3M54pJO0xlb2aFJWl13lvot59VCzXd4TbuAAatZjI5CYCOVCy7EsRNd2NC2Vk
Message-ID: <CAM0EoMmMio4kotBqbcJmFtf_c3Du=rhfvp+sMiAd0fHKowv6Vg@mail.gmail.com>
Subject: Re: [PATCH net v4 2/3] net/sched: act_gate: refuse schedule entries
 shorter than 10 us
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Victor Nogueira <victor@mojatatu.com>, 
	Po Liu <Po.Liu@nxp.com>, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 11:13=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-11-24 09:12:09 [-0500], Jamal Hadi Salim wrote:
> > This is a followup of commit a51c328df310 ("net: qos: introduce a gate
> > control flow action") as reported by Sashiko.
> >
> > The issue:
> > fill_gate_entry() only rejects an interval of zero, but that interval i=
s
> > the period gate_timer_func() re-arms the hrtimer at, and a few
> > nanoseconds is below the cost of servicing one expiry: the next is due
> > before the current one finishes, so the action holds a CPU in the timer
> > softirq for as long as it exists.
>
> The timer is programmed in the past, fires immediately and hogs the
> CPU.
>
> > On a 2-vCPU guest, entries of 1 us and below hold 86% to 90% of a core,
> > 2 us holds 61%, and 3 us holds 22%; from 3.5 us on the cost falls to a
> > few percent and it reaches zero by 100 us.
> >
> > The Fix:
> > Require at least 10 us per entry.  An act_gate schedule is not tied to =
a
> > device, so unlike taprio there is no frame time to derive a bound from;
> > the bound has to come from the cost of servicing one expiry, with room
> > for a kernel that services it slower.
>
> The 10us sound sane. With enough debug (say kasan, lockdep, =E2=80=A6) th=
is
> might become tight again.
>

Agreed. Unfortunately, there is no way to derive a "good value" here
(it depends on workload, machine, utilization, etc, etc).
poor choice of wording on my part - should probably have said all of
what i said above for precisiness...
Cant wait to see the pedantic nitpicks the sashikos will get about
this. Regardless if this is all they came up with I am not resending.

> =E2=80=A6
> >
> > Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> > Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
>
> There is no syzbot report for this?
>

It's in 1/3

> > Closes: https://sashiko.dev/#/patchset/tencent_4ED9536B0375C96183B2244C=
F7709768C605@qq.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> > --- a/net/sched/act_gate.c
> > +++ b/net/sched/act_gate.c
> > @@ -25,6 +25,11 @@ static struct tc_action_ops act_gate_ops;
> >   */
> >  #define GATE_ENTRIES_MAX     1024U
> >
> > +/* An entry shorter than this lets the next expiry land before the sof=
tirq
> > + * servicing the current one can finish, so the timer stays permanentl=
y behind.
> > + */
>
> No strong opinion. I leave this here.
>
> | With a too small interval the next timer will be programmed in the past
> | and will fire immediately.
>

see above.

cheers,
jamal

> > +#define GATE_MIN_INTERVAL_NSEC       10000U
> > +
> >  static ktime_t gate_get_time(struct tcf_gate *gact)
> >  {
> >       ktime_t mono =3D ktime_get();
>
> Sebastian
