Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F77333442
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012577; cv=pass; b=u3ioL+ecN4OYddU0CsO64lyQOSBRerc8dXbqFV6jLA4AkTRFn/N8vvonN1V65PRr5oWlXED6VMdnxJm9H5if0+hS6jcJgCG4WeDjsRQeyUO3grT147nQXt3c/oQqoJTkdbJoNvJCx3U7SULd8HG0u96AlipotpaPNKCIqj55cFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012577; c=relaxed/simple;
	bh=zZKKP+4IZYFDaCDFilC88QfoYGNpM2dFv0WidsWIKI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6bYMPfv1wIC/TewESCE/7WgxHDnvJgoFa1x7BJ5kpbJKn+vci063NAC3XSiPfAxRsLi1IYUngnMZoqPa2OdT3L3esRPH3qlydHEZ/TQvsNz7+1Ha540baAY1xL9fLcrzt3h3FK0+iWbZ2vwn+ksORkr+ekDz/OnDZBvs4I0Kso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lY6nNLbq; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lY6nNLbq"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50299648ae9so523651cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 08:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769012575; cv=none;
        d=google.com; s=arc-20240605;
        b=SIKpni5DRiS2F/kXyb7HCj1DjqHL1g7NBNKVu1KvVMEmUaAlHJJrAEWjenuxan9DYo
         Az5zsIYt1jSV+3DKiQ85rJhKkwNThdQtnka7QoBeTFhO3ubN0XXl0BuyqQReFWLukdAU
         iui5UPv/8Rflb1TEYbzjeQe+YXCuqebKyHHS2jZMBfKJRoK8Ig4FDlYSIjm3tOzDqI0C
         SbWYnSp7RKK4sAvoUimYu06P7pFYVbriTYAIITnD1yaFfoBd+JZ0T4tgcg10cpO++v0M
         awkbHHwrPGnN5IHzzfIO+dtKHScRQSG1k2KuxrUrrI2hn63oBsQ7s9VN2feCsDygU7ao
         r0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zZKKP+4IZYFDaCDFilC88QfoYGNpM2dFv0WidsWIKI4=;
        fh=NucS0mOGQ0uhOdWQw4WjxrSQdz7nedoTxfT55PnQbpM=;
        b=TFek72a0qnKLYG75eavKf0c1TKZvTXVX/fhIiE2EYx5VgT89OcpVYkCb5nfgS4C3GD
         p5Y+ChiNgc6xEYTXF240whMjEglgHURN+wO4GGBtDDu3A9eToZCD1KzzmK9JCFim6GGP
         g7JNjcTAF4cg+UwKiwiOkoHrNzBIJ/OB934mNQfqLL5qPVo6R7Bg0VwgZ5kqnGD3sT8X
         61m0ns/cf6V+HvwEZlQYrE1flG76/CWMivoCsLenNpdiFGCKBPi/ddpJ6MP3v0+5nTTL
         I1bJGoIAbvvUq731n/dzz2mwYs7zw878N0OHEcppXISPzFNwKpHLaTi7qAbzZS/d2KMi
         uSDA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769012575; x=1769617375; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZKKP+4IZYFDaCDFilC88QfoYGNpM2dFv0WidsWIKI4=;
        b=lY6nNLbqwmj6wRQnqiKB+jQ9SVLucOnp14h5rMSmfwNtcRqIYZFObfX7rlPUq4wIbg
         WcEZQnWgPoeniNWH6xqJ48bFqcMSjz9GZi2LpJP79Gy6RK/xMUIRRMJoKr1x6ohH2Mhb
         gtO4vHe+QubvqXKxjBzN0MRL2hWyKn9s+SP+cngR6F16eJJu6HubnyzhNuMfYzkCwDg8
         8vHFPrvZhc51FdBdK+me0/ue/71gORG1mx01ZC89lp8HwMeLbICWmqlEabsWqogxVpQY
         ngGutLSdj0bMb8JjxlLBISr8snWBOTbjRFwsBkSiqvm3FaLdmgCz103Z6llYnRW9lI7G
         b2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012575; x=1769617375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zZKKP+4IZYFDaCDFilC88QfoYGNpM2dFv0WidsWIKI4=;
        b=crNL1VgHPpbPzm4jmTIYU89eAFweyEvwdLJlJKLxVvG88+0urs8S1pnGyQBCKw4wEI
         thidktyvGLyy6UgNfW4vygbCrO9wVaAKzuxVXxLMl918IDpe1UpZr7WTc5hxllrCYNSJ
         2KcPipji8A0so0nadL1WKDzNFIGYeNr++MLhugCmlwaorPgTUrabxgcJmL4m7auGAbAv
         RbB7pCOUHtMbXgegAaeAzTav89IKq35cNbTAGXJTkkDYepIq4B1b1footQS75wEJJXZp
         9Jkauqc6eSHF/Qu+vFJqAnX2IGqGAiHUwQzcf0fQeOHcsE4YdNsDQ20pdgjBNAY5lj9q
         apwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs2xSp72WaOtoWDnPSw52k/ZgpAFpBgKUjKCF6l01a5OdYV8U+D9srETcOISqeWrRZTvakESozP4Omcj3izQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYr+qD+Z6Ou6NJ3FyU7L1fC18/VO2GQk4r2FLS8RvirtsNEkjV
	0L4nAnDKpI1ZP8zm0w5Y+DA1TQ0bYkABnAOa6eqwbD/PDBWWr5fhWi50E5Yf+XMY1q6AQHUl03w
	jCLNkwkTDGTUSX1ePv2jRTneNFOGPhDKCKqLZYtmC
X-Gm-Gg: AZuq6aLHrOO8bdWnlJqltBq3hxA8frjOam505ceicqD2Ryc7J9bT2MbyQqvS3yLE6fS
	YN8DpEXwxkA0HqFOkWtkgUt5WCZ8lGQEZaSIIvV/0aIkARMTYo5vq2Dn752pjLeQtpmUEpflvRL
	+bWTbwkM3HBke7NWqTfnhjoVqizSchBgOe5cKO7tfFXibsrkWeU+ZgbRDoPtuwTw8+vpJzsqyKo
	ZFGQpzGTChSTqvvTOZOcRj0S5KkkhsGT5WxplkV7K5Gb9hGtfLelyLizDqS1SPe7rWnj8ce3U6E
	IsYQf1H52EgNerLQOuQn1ks=
X-Received: by 2002:ac8:5f49:0:b0:501:197d:32af with SMTP id
 d75a77b69052e-502e0b52d5dmr15160751cf.0.1769012574328; Wed, 21 Jan 2026
 08:22:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz> <CAJuCfpHaSg2O0vZhfAD+61i7Vq=T3OeQ=NXirXMd-2GCKRAgjg@mail.gmail.com>
 <c17d4413-1ffa-4d3e-8d87-0e7c2b022c16@suse.cz>
In-Reply-To: <c17d4413-1ffa-4d3e-8d87-0e7c2b022c16@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 16:22:43 +0000
X-Gm-Features: AZwV_Qhsac_Z51cYOHKUSuzgrrT7X6Hd2cSKwh2Th8VEqlGKrAYEFKE43eae864
Message-ID: <CAJuCfpFUsSKf89tVe6u29SpN7sL1X_721H5iv2yGwt-Wa6E_xg@mail.gmail.com>
Subject: Re: [PATCH v3 11/21] slab: remove SLUB_CPU_PARTIAL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 2:22=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/20/26 23:25, Suren Baghdasaryan wrote:
> > On Fri, Jan 16, 2026 at 2:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> We have removed the partial slab usage from allocation paths. Now remo=
ve
> >> the whole config option and associated code.
> >>
> >> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >
> > I did?
>
> Hmm looks like you didn't. Wonder if I screwed up, or b4 did. Sorry about=
 that.

No worries.

>
> > Well, if so, I missed some remaining mentions about cpu partial caches:
> > - slub.c has several hits on "cpu partial" in the comments.
> > - there is one hit on "put_cpu_partial" in slub.c in the comments.
>
> Should be addressed later by [PATCH v3 18/21] slab: update overview
> comments. I'll grep the result if anything is missing.
>
> > Should we also update Documentation/ABI/testing/sysfs-kernel-slab to
> > say that from now on cpu_partial control always reads 0?
>
> Uh those weird files. Does anyone care? I'd do that separately as well...

I'm fine either way. Thanks!

>
> > Once addressed, please feel free to keep my Reviewed-by.
>
> Thanks!
>
