Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795540278;
	b=PzFykDT8COkPkrqthkjckcYePmEAfFXa271JU7G7ujVuLq3K7N9TG9ZiVIPV2WVWG5/a
	 /c573IVB2NQrZXcFY4YmOzytyZnf7IAqcZxvGvPdouXfO4l3xIlA4xbYbnHSQNktWERiH
	 w4PKDZOMkE+ANaHkDM/IdhMvfZZeEjKhEijds9j6oyOCZT/5mPOfS9T3diBaThA0m77iZ
	 mV3N3qacYm6BM7vrFeZFCQiKASNq/opsuR5rJJ9Q9l99Q4TWKma6aWCpV63bagBWQu6JR
	 VXiDv+lmbN5nLBl8fPjGnlZmch2EXIPJ/OQoqPigfep1a4kQrp7Kl7zIhWgrTdKMGcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ke4DMY/5oHPgUmAeqSFagfiX14Vkl9nfeTs1w7gvuG8=;
	b=0NNUdGT57aSqc381FThDKjYg7mEve6pYFvv97gIfSoVWn20jwNsV1N/XI9EUquZRT50W
	 +DVHkisEBReSjFMDlkYeEvSQeWU677+7M0c3JQE6yAwQzGu9zlTcK5xowk88lW0Nzsorx
	 IWxaMza+IEliQORHkmloqg1nFErQm3rIad01lBvCcvTMbVlZtJeUkh0GXa3ModWcuM28f
	 8GqPnd2FLKjyQ+soHV7TfX76JM9sOZB69BDpvaK4W9tMbqNmjlBVFItyxbuGxRKe6nFsQ
	 NpeRBudSbWvUMtTjJNOxkg4srT//pm5zeqGIk85UGJB40fn5CH+mQ+rnx/I+P6nfRJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=fcgF7KOH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFDC606A6BA
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 17:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BFDC606A6BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=fcgF7KOH
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8c700d6cc0bso2935838b3a.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 09:11:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795540277; cv=none;
        d=google.com; s=arc-20260327;
        b=s5VaV7QbjM5QThL+SF1qR2nrsMVqBGBag1rRjAuX21AeNoyiFIaBLm0zuEiB1LMjnO
         W7R8Cr1ehZunoEzMPa16Wkg1pPRUgxjRUjhFb+Tvx26x2mWV7UfG9xyyY5dK7qSdLXmU
         iyJxvcz1rOgbAdux01B90BmpYfhRX61jRJc7QjIoHYG+E7iQ0MH/tOhG5+Or3WbPASsV
         CkSUhaLlrLhCZZDkFIeDvS4daXTTQjnQUWFspQ3nKwIMtP/8eqm3iRJBzztk7/EXyWGx
         PYFTwqJmo8xEfgJqHxp83MwCXhHx8kaguw7y+ENlqxOU7bCm3lkdMUqcj0G1iRH7aRzP
         lnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ke4DMY/5oHPgUmAeqSFagfiX14Vkl9nfeTs1w7gvuG8=;
        fh=IqiHtodKceYjFSA7y1gs7ufp7CXgLzHi/KJraMxgXmE=;
        b=GMl56HhECn2b2feGzMwSGsjBvhFAD+a4Rs2o1j7gc+T4QTlou9EcDAlX2Q/RfRSO7p
         VOddyN5shpXVSKaHtUWJHoZq/rXRpKy6hRksbYDDrJc9GAVxKSGtdb5GDkMf9UejktL3
         3nQs3LFF1z7aBtV5u0IuTmh3yJVjubf5FJUqoaH5t7ClEMjD1WZryQYpflqbbIvEmSz5
         yVrJ7p2VEfandOQt0ybHUpptEGER1NOPB2Ns4MFM//7sPfCUp968MLd0LNu83+Ht7efX
         Wd+9aii60BLQ6M0dIPkSJz0d7v6xQBqo+H1BwwlN/+LyemBf1MA2RQQd9USb5rdlgSQX
         gwNA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795540277; x=1796145077; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ke4DMY/5oHPgUmAeqSFagfiX14Vkl9nfeTs1w7gvuG8=;
        b=fcgF7KOHPGnrP9VIh35m7v8Ljg8Ly4d15Wo7OkrPh3pai2uUjkMQIgT26s22r51cUO
         PdMRmHAE3LGeBIcVZ650lVvf2egsDvoaUVjmf7QZAvYYmAY1uqgWbj7Q0rLMAFLO70ZU
         XWvBp0WXTtKC/ccbVdNq3r+J0JcRy5ly0tpi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540277; x=1796145077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ke4DMY/5oHPgUmAeqSFagfiX14Vkl9nfeTs1w7gvuG8=;
        b=Kenk0mCZg1uM8pc0xiDpj/z1Q3RVb8i8hJiI7BWz9ScYS7izVsOm+TjljbEG9KbRqc
         mo+yAncF8Yo3aRLrpYF11C8SUWxFgRMMvFc1FtFN/6oqb8SVJgN1d4SOMnEJROsHpfBS
         dMyxRWpT67mogSFDTjzfcBkF56FY35Egn+k0a0Njtc9jGG8ewyJB2zOpI51uDqfcwC2A
         VaTcbzqxF9tPkDF3/BO3XwisxqufGb09nqMdZAnwjoX4zPYc7aFbZnpGr5vpPWnJZpbi
         Y2uYugSipnFI9ucQNr3Q6/YdnPoUCVGSq7Jgt3gp1B+ZpE2/7cEZYKqUgQ07GbeXzfJn
         sEew==
X-Forwarded-Encrypted: i=1; AL+hErHYA/zw+zffBkhx6aKYLFfvM98ztzIA2FpDLhSfSB9joJlENDrcy68rt1JGc5tgtRBo25l7gC4wZ234GteT7w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8TyNztSSSSey8mSX4R0ZAJQDthtwbA1Xul/mDehwuGsTG9ebWx
	ROExQNZUlZT2Qd2eYoC4fJFFNaC2Vm+TRH9vUPNxCRYhYBzEzWlcxTSAi6+oJVIu9HFJi9EqZvt
	YSHwncRwsOyYbWVfay5bJza4e4VYa035Q/dPa4bHJ
X-Gm-Gg: AZFdTZfgSzi00k/rZU0baTrVLKRRsapCxG/bu0k29ZT9Q5PCsTCuKNtWoY2/J6a9efo
	ZWp4Pps5SpfMisxsl61CRGi+9ABwB+G0al7vgNWYoH4F4mLs3MXPujlP807ajOw6I9Jx2y4Z2Ns
	7X5AqNrvkyj7n5i1UZ7cEck2ozKV+WhQKdTWY4QFIaGy79SyC4qWBH0kkTL8EtKnqlXBXp3VLKC
	Yi8Bq3PNDBvP3bi0RRK3k5FYXS0uH8zmxZWHGyqiivQfAAYQTlUWKG9MehjpHZA7aC+1m7aMSB9
	Lkh5M0x/x/cCVv6oHnk0X3s8sCdR7YmkUqS9FwXg7aVhP78mJ2CbDYehBKet8gVYWvb4VjjqVdW
	H4kZJUUnTpd2cLue8k41IpUjxEeWzYhV504TBOBrLZvXpmnIntKT8Jcj00PmOSwTknwQZ8tAEq9
	6CuWMk26cs89yyV1g=
X-Received: by 2002:a05:6a21:e089:b0:3d8:e57a:5a5b with SMTP id
 adf61e73a8af0-40149f7bc79mr13550670637.5.1795540277488; Tue, 24 Nov 2026
 09:11:17 -0800 (PST)
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
 <20261124161258.vLyrm8Y4@linutronix.de> <CAM0EoMmMio4kotBqbcJmFtf_c3Du=rhfvp+sMiAd0fHKowv6Vg@mail.gmail.com>
In-Reply-To: <CAM0EoMmMio4kotBqbcJmFtf_c3Du=rhfvp+sMiAd0fHKowv6Vg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Nov 2026 12:11:05 -0500
X-Gm-Features: Aa3M54oig4IWsvcX3iSlWHrklygop5_tvIrr2s7WuHfHlt2lcJnss6T7_wTd3Ko
Message-ID: <CAM0EoMkEjxCo6K9k3MZH0U+3na9soMNE0gouddwOTzUYXcEunA@mail.gmail.com>
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

On Tue, Nov 24, 2026 at 11:58=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Tue, Nov 24, 2026 at 11:13=E2=80=AFAM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2026-11-24 09:12:09 [-0500], Jamal Hadi Salim wrote:
> > > This is a followup of commit a51c328df310 ("net: qos: introduce a gat=
e
> > > control flow action") as reported by Sashiko.
> > >
> > > The issue:
> > > fill_gate_entry() only rejects an interval of zero, but that interval=
 is
> > > the period gate_timer_func() re-arms the hrtimer at, and a few
> > > nanoseconds is below the cost of servicing one expiry: the next is du=
e
> > > before the current one finishes, so the action holds a CPU in the tim=
er
> > > softirq for as long as it exists.
> >
> > The timer is programmed in the past, fires immediately and hogs the
> > CPU.
> >
> > > On a 2-vCPU guest, entries of 1 us and below hold 86% to 90% of a cor=
e,
> > > 2 us holds 61%, and 3 us holds 22%; from 3.5 us on the cost falls to =
a
> > > few percent and it reaches zero by 100 us.
> > >
> > > The Fix:
> > > Require at least 10 us per entry.  An act_gate schedule is not tied t=
o a
> > > device, so unlike taprio there is no frame time to derive a bound fro=
m;
> > > the bound has to come from the cost of servicing one expiry, with roo=
m
> > > for a kernel that services it slower.
> >
> > The 10us sound sane. With enough debug (say kasan, lockdep, =E2=80=A6) =
this
> > might become tight again.
> >
>
> Agreed. Unfortunately, there is no way to derive a "good value" here
> (it depends on workload, machine, utilization, etc, etc).
> poor choice of wording on my part - should probably have said all of
> what i said above for precisiness...

And now that you bring this up - this should really have been
targetting net-next not net.
I dont want to resend (unless sashikos find something sinister) - but
Jakub/Paolo consider applying this to net-next instead when the time
comes.


cheers,
jamal

> Cant wait to see the pedantic nitpicks the sashikos will get about
> this. Regardless if this is all they came up with I am not resending.


> > =E2=80=A6
> > >
> > > Fixes: a51c328df310 ("net: qos: introduce a gate control flow action"=
)
> > > Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> >
> > There is no syzbot report for this?
> >
>
> It's in 1/3
>
> > > Closes: https://sashiko.dev/#/patchset/tencent_4ED9536B0375C96183B224=
4CF7709768C605@qq.com
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >
> > > --- a/net/sched/act_gate.c
> > > +++ b/net/sched/act_gate.c
> > > @@ -25,6 +25,11 @@ static struct tc_action_ops act_gate_ops;
> > >   */
> > >  #define GATE_ENTRIES_MAX     1024U
> > >
> > > +/* An entry shorter than this lets the next expiry land before the s=
oftirq
> > > + * servicing the current one can finish, so the timer stays permanen=
tly behind.
> > > + */
> >
> > No strong opinion. I leave this here.
> >
> > | With a too small interval the next timer will be programmed in the pa=
st
> > | and will fire immediately.
> >
>
> see above.
>
> cheers,
> jamal
>
> > > +#define GATE_MIN_INTERVAL_NSEC       10000U
> > > +
> > >  static ktime_t gate_get_time(struct tcf_gate *gact)
> > >  {
> > >       ktime_t mono =3D ktime_get();
> >
> > Sebastian
