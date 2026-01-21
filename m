Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7A4A341B
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014651; cv=pass; b=nB1TV/T+OpTlktaw2gIFpa8/GJ69hvciiP+XcEeFS13or7IVHB2IjACvvtnQEIM/SAAM6QFiO6Qel/URHP7YrpEAZAn5C8yhRv9b1x6RbLsqnceef4tDjq+OA9WKvzl7X6nQKtsDI7zGg0Z70YIeeLlnASb5HHDvrBP72B5FTpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014651; c=relaxed/simple;
	bh=u9ePfgEMWAzzAMBpjCw+oyPYM1jqTDkiGANBsXIAnes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZrBW6srmQ9DTcdA95aQPFAj/GPMys57BGdLPDrv4/2FFz4ns2TBQQ3H3V/OpaxaO/X/z23PIBR2UlnPZ2ru70vAn6n/p7x9rgpYhSfGA+3Ax5J22jXsC/NWkA3M9Zwu34FQm0RY+b5B1HNfYahIfh1UnfnxhTZVrXCzlybHgHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXqgJIY+; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXqgJIY+"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50299648ae9so547911cf.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 08:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769014648; cv=none;
        d=google.com; s=arc-20240605;
        b=EImrHtuaaFgVaPXfQF/Ex6clhLzrzuq4SPQZdpPLfSRz93OsW99OoZW36NsqwMrDlh
         z0r+rkctJZzs6ci7ii7VtX2Ev/fkkMsH0uLkXdeuBvsFQdlL994HlzLIV4kS7P9wBnZi
         xJNzx9FRv26th9w8B7MoWQEbHFJT1i1InUaa9u1u0v+MTMXy1LJzYXSSOwobSRGnA3fp
         02KtMUTrRl7h/qONOtiWKavP4jS6pYZG0du/c6+JLLR9WIwd0tolW6d+sFqQlU2mLPr6
         5N1G3R1BtzYzXwwWWwI11CoJk+l5cVr6lh/zXaavqxlYQOvSFp115paa+QXJDzO622+3
         ju6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DzJlvh2XyLMGkwtl0QberzuQSLWoZAkg3qQo6w3w0Bo=;
        fh=uZrCq7UfCGwYsYPtpYi4raYCj+gxvMyboHqUr+OPA2A=;
        b=EcxRjco6MkI+Vhb0gP9O+kqkrPUBG+YyYEp4ShZmPDDH/xkuWPjLJ83M65ZlY3tssq
         jpK9kc2/r+s2Xt+QDSIDMg9R19uHolxTLwx/gwElaZlsp7AZIsGiH0RwLdObf4f5e5nD
         2IVGJ/LqqU/zEvwmoj7mnEjBwshbL0rSgPTCO4CFdRyacTjQaEOeyxi6TahU9S/7prct
         a+Sjej0jqf4jv6F0Lbd/U83T1604u/nZTB9h3mRUpO8aCA1rZE/alsgmW8ZoG1U/XNYX
         UtKMhgR8D6CFQ09rIv0X2/l0FrunQWhT6zh2+By/H0D6/3RN9RKsR8k2BHYHSv+efaxa
         hc6A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769014648; x=1769619448; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzJlvh2XyLMGkwtl0QberzuQSLWoZAkg3qQo6w3w0Bo=;
        b=gXqgJIY+JHLoTqq/P0BKL7svjEGSX1RFG1zz/mKJMEXvPHajc47b3+ABgkrMT5o+jI
         J6IejX4hTAS7Nlv0iuqXkf/b93GIaqC73ANmr4JKNQzXm4AgE2+RiPwL4/QaghE0dEy5
         REL0TWBFpQfamlfgFKRzEolkS/JY1eTC8y7CmqXLPAMiDKga6mhZ1AWjStYVmuGlkerN
         0maeoNME81pAA59dTTdcYpMy4fZNhDV1+xW0rCOvMKkJxXK90RD8cfPziyl+yVwwHWy0
         aBoq1luU7D1jjYzU+QPompMCqNMRYxxH5pmrePy8FSCmA5rNEpgNH1b1hIKpJTs/RAsI
         hEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014648; x=1769619448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzJlvh2XyLMGkwtl0QberzuQSLWoZAkg3qQo6w3w0Bo=;
        b=K0QmprbltAWpXsdpJ7Qv4LTSyhOCZzPQ2p0DSbVyL1mfPYyuyz2/j2s4+cEfbGz/sR
         JgqqoRDXwkH8clnnlLDD/vrDtAiSyNdTTIuphV3sKiGgTvfErbCff++qnPuRb9B7B4bI
         2kSfPw0DzmDuhUE7GzGtTxhbP4noEHx1rNqq+l5K3LjV2CYJGMpUPnAmFwlv9vfmawiO
         W+mvwm2veBQ9TtB4KckpRz/h6g3UANdj26r6E15SXcMv5P3yCwNu4H816YqNooPHpuiV
         wLp+WjMKGy0ixtOaSP5pYZxddKt3oWWdt0kqeR1iVgmbO9BffX++yocE0wcWivMabi+0
         II8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaDOAd59TZWVz1Kgu/45pYlxtTEz589krh3KjFKCKxZFPmImExqptIn8lFV0ZSvPK5aiQ4Dad5EYjLyNTumA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ3HsuJZ5Xjl7wHOfQWiDGPYZeGe6jpUjFgx5+n06l3OzeoAk8
	PDAVwWBn28+Zt7Mz2v19aBwf9U/wSjQtUS5F98ueNCtksfEv4kUlPVXF7SSEUXQFmI08K6G8ifC
	cX/6iw+L0fRYMdaghgkVZ6gnvwQ6Dvp1iDqog6G3A
X-Gm-Gg: AZuq6aLfXG5wNgfhLEVPkqX67g1tCT+WU26cK5rsb16Ezc+AoPGy9+e60C4bdnMac/0
	Ss+hVOX969hVdXj+f5G0AcgGjfx5SYXkJt5IgFokbmXS2QLUOX82z3FaMV7e7b+1yRq6mEYcxbl
	peRSvpWTUD24QAhqFyc1tmmVSoXCXW5UT0HlJmRexYTyUL8YXxFKndZ9qQeKRba4rnNbJXDESm8
	0y1VeNZ2sLlZgoSaiGKntixtDil43CfzbsTD/jLnfEt+Vj3Q5GTovQcpZ382w75C1NBNq4PDNF6
	Iv/1XA9DEYds6BMSY9+s3+c=
X-Received: by 2002:ac8:584d:0:b0:4ff:c109:6a4 with SMTP id
 d75a77b69052e-502e0c0d426mr15219551cf.4.1769014648007; Wed, 21 Jan 2026
 08:57:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-12-5595cb000772@suse.cz> <yejhiw37av3o23z6s4oewlmhip3iqxxkkfcjp2jhlo4qf7nm23@hojkan5ym5cv>
In-Reply-To: <yejhiw37av3o23z6s4oewlmhip3iqxxkkfcjp2jhlo4qf7nm23@hojkan5ym5cv>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 16:57:17 +0000
X-Gm-Features: AZwV_QgOY9Ovo2gtiQ4jhpdmFVjl8h8HKayG692yA7UEj4JquBoNIBa9LT-cydc
Message-ID: <CAJuCfpFaeYyzHirCYUPT0JDeavuq5UGqegW0OMata31XbYGnww@mail.gmail.com>
Subject: Re: [PATCH v3 12/21] slab: remove the do_slab_free() fastpath
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

On Tue, Jan 20, 2026 at 12:30=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote:
>
> On Fri, Jan 16, 2026 at 03:40:32PM +0100, Vlastimil Babka wrote:
> > We have removed cpu slab usage from allocation paths. Now remove
> > do_slab_free() which was freeing objects to the cpu slab when
> > the object belonged to it. Instead call __slab_free() directly,
> > which was previously the fallback.
> >
> > This simplifies kfree_nolock() - when freeing to percpu sheaf
> > fails, we can call defer_free() directly.
> >
> > Also remove functions that became unused.
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/slub.c | 149 ++++++------------------------------------------------=
--------
> >  1 file changed, 13 insertions(+), 136 deletions(-)
> >
>
> Looks good to me.
> Reviewed-by: Hao Li <hao.li@linux.dev>

There are some hits in the comments on __update_cpu_freelist_fast and
do_slab_free but you remove them later. Nice cleanup!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Thanks,
> Hao
