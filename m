Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBDA33066F
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017157; cv=pass; b=Qg2lw3wRAgKGQwNmQFPQB+sfC1T8Dw4BunXHsQXDSVjHlNwsLQveaP2PaaQ9YAtyujj+bMiO7B5EpCLGjQJDQmE4yocU6h20YhORc91cvRIiw89nhFJiXQqFAoX9towxk0Imbbbi8MRQmTU3WpGE6QjoAGEu9kSg3ki7WT+4uPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017157; c=relaxed/simple;
	bh=qCmYva5jEN1tFWNy0cKXK4uKFZcKVDLG/DhghvX0UxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAJKbBlKiYFt+Yl3LCSgSIhwgVoOlQVViX8S2O3hY7FCudTs3J5Y1HNf+admbKJR3gOVjuxeFwAaX217IlopLUb4nDp10vCSYOknq7in63g3axoUJmPm623omhxkW36s9ZN3h8lmQ72hDuxM+pq0+vID1XEf/EZfZmx4lh5D3MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hWV+eQsI; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hWV+eQsI"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-501511aa012so2971cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 09:39:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769017153; cv=none;
        d=google.com; s=arc-20240605;
        b=ZaE4AJJwjdB6GA6orUsIzShCbInW+qQ4QlURzuV0pUAhWbAONOtNLq3thcOCqagUw+
         3r1sRMWssksT9SQY/A1TnVKwzmphqHCSzY1oRsef+ySszFhY/7Ly1CrM+oju3q82CdFz
         M5ciB3lDmrSxm85JHWK5XtF853ZbBzA2vBg/jtqf5+6+82OvBS+2Ur97wGoIxfFKunul
         D9g4APLqVBFR2lw+58BgHRBlHlaVjylPRKRDLcPO2rVMFILglCMvFMhYo1D/NQ9Int5P
         NVuEYdwsBcSLxFokI0FmDErBZ7VNh/acPzxSHUvsD0CF33I7CVauuHFPwp3ZYYkWxUWs
         EErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WZPB/nAuSxHMF8z7YKq4XwyLCyx1N2zE8w1NIox3Cbs=;
        fh=Lnme0hed8hwouDRnQdghyjIdjkGFi/OW+KQ+yYZRFfw=;
        b=g0fgcD8neuolzpM3B2iSrSILDmPvfMJ40+rOJnnClZbPQjHgjUXQYmSNb8eys1wYuH
         tSkk1QMdja3hWhLbMi+hOCjXLQV38ZOgCdKA698FRFW9XeU3DyGaJhgoAAJ7b+tRiZWM
         knWPYvduz8klF8OYEfTswBkYVYrgS75KUDproMYnISaTIJE3M59ifNW9cS5L8Ua5opQ5
         TKt5ovpAzm6aGm8eswFYNSDLBjadnvs2ZEu9F21wUgyqhPzalmVLqZt76IxcImCYJ6/h
         m9Km5m9udagJqBCXv2c1lhvko7ERlkiCkVFl7CIraWAxlLphgFcD3Xfadtlju1xFcZ5e
         cMtw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769017153; x=1769621953; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZPB/nAuSxHMF8z7YKq4XwyLCyx1N2zE8w1NIox3Cbs=;
        b=hWV+eQsI/VlNrSKn0GpC1uVdG5YPBpASKqensBD+SWyinH94Us91QkVYLVoVgVsuG1
         k4Wj6FIrRduiPT/Y5hcjpYdNdQC/BUZP9V9OeZJDIVQ7eirpkO2FGSvkWoZmYFMa4JYa
         as/IyCAzN+AcrhjBcfCLpbEkdgDZzWmLp2ZRcNsv2wIb218SyJIpYhsd1YNU7/n/DiAv
         CAmjZxyIWy1n40ExInXbO32Gy2FmX3O2Gde8eYrJ9PRmq4sCb5LtI+mq8D8RIZQtUvb0
         1qiTgNZsnuG8ZjaEFYY5dylnzDMJTVLtUSMWwJo9RfozjUNVLxm5A8FFd/issWvYrb7e
         fJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769017153; x=1769621953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZPB/nAuSxHMF8z7YKq4XwyLCyx1N2zE8w1NIox3Cbs=;
        b=OlNRPeMi3hWIKQCnGqGkW+eZpsYKNo5irLGVQtAEa1AVXVdzyC69Kjqs+8kTerUKuM
         tdpe1f6DcdJ8e+7pr8QXVgU1d+d1rApTSyRwJVTRLEV18vflNImiOaY0xBTCwQa45d41
         latdA3zGvI9S3F2NOp8ag8AUTYbSc/9OsrmxiqkC1RxOm8T5MrjBCgOMBD3S8uurJHpA
         qfleMLRo4vs4rnMigYCn8LwiIQdNcjLsShBeEb8pkj/cAZEcPa57Eijw/At85F3IgVqF
         OQMwkzIGMkc6fL1nC5ifNnTbqpV71Wo6sAlpWlPbiMxJsoCR4zREP+/oDaen/PeMoP42
         OFxg==
X-Forwarded-Encrypted: i=1; AJvYcCW7pPC4h1/WxUQm+OX5qEN4NFASU/+3oHcZUhHfgj/am+6eV5UzlUYnSZMmeHA7WSJZ3rcNcdvw5o5b0XiSjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YydX+mig7EtgfVgHofGWeTPNRIoR+lJI2DY6Ngg8dr+M4OufY7+
	cD7i2JD3EmSD2BUinPB918l3MpvMd9AmYxBYvr7GJ5hURFWro2AltA1M4TlLlfMmlyw99J/eo8X
	SrhKXKUdD4WLm8QO0HldFZSWzbI5cHLDYE56cKl9S
X-Gm-Gg: AZuq6aLoKVu5qcYxmCTKOBnHIYloj7OeSJJOO3B3y15D7k3cNuwBQF6XF41SzsbsgYV
	CWi8o7tHO8uTSSWZF6brMCIQMyEH8O9erHaUVJI24DnM5KO082j+olkHk7gd4nx1p4+st8SbUrO
	QRZ9oRe4Se2UNE/KcYyAI09j5SIVVPvDa/upRT+vmRmCnsdQCqX9ISOmhKzi0lADHdfn/tAU/Qf
	RCqFIJ9txb+6D/eFhjXK7WtZAEgw/RYTUWvw/fEi0GCZa94k78Z7nChT0I5oBvEm2XLjcVySJhe
	F+KoobTsmyQJevVt4K3LSGk=
X-Received: by 2002:ac8:5994:0:b0:4ed:8103:8c37 with SMTP id
 d75a77b69052e-502e0c6494emr14807601cf.12.1769017152599; Wed, 21 Jan 2026
 09:39:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-14-5595cb000772@suse.cz> <2tvnelafuozzzfyvmxvflqmx2sepgy7ottnw4n2trkh33rrk6b@oewlapq3smvg>
In-Reply-To: <2tvnelafuozzzfyvmxvflqmx2sepgy7ottnw4n2trkh33rrk6b@oewlapq3smvg>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 17:39:00 +0000
X-Gm-Features: AZwV_Qi3Y2iex4LEenR-glhvYF5fdvLAgmEL3JsgkohqCrj2SiE002EgBpgOZDM
Message-ID: <CAJuCfpHGSxK99sSDmnh+xqJOaqLX6vVoH4oyPUS7J6J74RU=9A@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] slab: simplify kmalloc_nolock()
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 12:07=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote:
>
> On Fri, Jan 16, 2026 at 03:40:34PM +0100, Vlastimil Babka wrote:
> > The kmalloc_nolock() implementation has several complications and
> > restrictions due to SLUB's cpu slab locking, lockless fastpath and
> > PREEMPT_RT differences. With cpu slab usage removed, we can simplify
> > things:
> >
> > - relax the PREEMPT_RT context checks as they were before commit
> >   a4ae75d1b6a2 ("slab: fix kmalloc_nolock() context check for
> >   PREEMPT_RT") and also reference the explanation comment in the page
> >   allocator
> >
> > - the local_lock_cpu_slab() macros became unused, remove them
> >
> > - we no longer need to set up lockdep classes on PREEMPT_RT
> >
> > - we no longer need to annotate ___slab_alloc as NOKPROBE_SYMBOL
> >   since there's no lockless cpu freelist manipulation anymore
> >
> > - __slab_alloc_node() can be called from kmalloc_nolock_noprof()
> >   unconditionally. It can also no longer return EBUSY. But trylock
> >   failures can still happen so retry with the larger bucket if the
> >   allocation fails for any reason.
> >
> > Note that we still need __CMPXCHG_DOUBLE, because while it was removed
> > we don't use cmpxchg16b on cpu freelist anymore, we still use it on
> > slab freelist, and the alternative is slab_lock() which can be
> > interrupted by a nmi. Clarify the comment to mention it specifically.
> >
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/slab.h |   1 -
> >  mm/slub.c | 144 +++++++++++++-----------------------------------------=
--------
> >  2 files changed, 29 insertions(+), 116 deletions(-)
> >
>
> Looks good to me.
> Reviewed-by: Hao Li <hao.li@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Thanks,
> Hao
