Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9826FD97
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626372; cv=pass; b=rtfA6X61G1yiPX4U6ONZcV0gRRXnIdLfqOK6Zu9l/YT6nLDU1Gmo/r/x19dZsRfpkLP4dcCz8W02peznA5uM06Np/TdHn2h9R8lIx4NDR+AMNYOsoeXUm+4y6HM7kd9HiipcnKP45Ri2nXhtLsIfAwCYw+Qr0Wi/2iG4OuCjdtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626372; c=relaxed/simple;
	bh=4DIUfbjuD77rfoy0/pH5dRWn+Y+8N/OP1jkZtGJumo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3SppP1IKc21P9lO7hZ2XYc9PiaCfOD1/bEg/zACKXzMTLHoR8kTdgZaj7YNkzYksM2tdB5VNdp/ws6oVc4WTkUdlF303h8P6Fmete0V0ciB8oH/++uFt3NAT2m9z8ryU+wa19P+37UutrMpCgkBc37RVmywKhzvUAytuHSYf8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqS0lq0W; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqS0lq0W"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5033b64256dso36481cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 28 Jan 2026 10:52:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769626370; cv=none;
        d=google.com; s=arc-20240605;
        b=NjprHQCyULd6YQbpwLPDvRB6mi/+ljShj7WI9oT6fqX40SCYnTk9tHL5j2r6zvb5UZ
         4fJCyj5nqgFcsLyvIaWm+l0U/wQl6jj5xilHh6bmQfp+fND8QQfck4/tQnigRAWQe/d8
         eAe6G4ynDiuEgLTEVsTobUkESmSZfdndDrJ9TkwmhTVSh+orogetEYVyXhl3STPwoxWH
         HQgBSHHxRsLfX4Z4AL5k64B/DgvUFcnOeZsxTful9alkddz1X5Qe7c2DKxKL2fv9sS4k
         lLRge0y6MTMbUwQJSH9MvJNgpjfnaMTJvG9K56rPRzcTtYZ/FuJGX2HHy97J3q6NvUPq
         gs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHU3SBN4kSajXpdSc5kb9FPIvGlVuAgxov/ZwG2Suug=;
        fh=fgD5huhoMZ4Vv2MXBM7//ZZwD3SYmtSjqh/kewdMKmE=;
        b=RGlE7F0Oz6O1b167jajtB11C6DrBKFNLCt1faDSAFL//GLAEqXXMJ05UxvlISdFXpV
         sLYF3ON4mjulWsJIPgCw4rjyZNzLJaFrlYmB45kpWJOznljXTM/zvnI0iFCj3B4wTnxE
         c0vLJciQFDNmpEGgmH8z1It5LXNVdee1ZVdZBqUJn0UxMf+a2+RLxUsuWt1qoPjvAJ4O
         AbS10Z627DYfX5P8jb6D/ayukpC7LGMhiqatcJK44lfi+06SQVCEf2DNtuOE5iRXS/Ze
         UMelGBK748YPm70q8T9uFoWsel49gKQFTnuPNBewy7bJm4dD4kaZG/LCuLowZnuYm/0/
         iUZw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769626370; x=1770231170; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHU3SBN4kSajXpdSc5kb9FPIvGlVuAgxov/ZwG2Suug=;
        b=eqS0lq0Wd7nPjB9uBCIDK47QtYYBEq9q7kqcWWkhrlQOeue1xMrFI0tQa+Ohn3DYuE
         cF1bIRP+ruW9QBsdxOb+ybhydwhEFmlUoxqdWMjVnCSFaSDlX427aKcDInDbdLaa0q/W
         Y9EKLKcE3LUPmjzGokwaQ2iABslHlBF569tmx6ttIq1okbmimUH76+vtw8oXcMJc4FQw
         7ewJh+xsS4U8AQIRb3VPU5IfuEBXI1IyxBimNReQVwnX+XeHr39UYv4vYtURgp4cf4V4
         e1oSQGeuQTvWlrJHgnhwz0F5Iv+0v2yUzkG5rBFf3VrU3znFCFTs/8a+LPFll+Bah0WA
         PKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626370; x=1770231170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WHU3SBN4kSajXpdSc5kb9FPIvGlVuAgxov/ZwG2Suug=;
        b=O+gQuS86ZR0+m6X9H3IP802cin3hrytTPXfkGlcEu4cLKd+X7wvYf6AIcUd7GxTvgE
         GDlGI7NH4ZFHsDk31O3kp4Ik3Zvacr7Eg0M2k5UkcoQ/RaF7zsHK0/uJhwLF+aMLFqvg
         Wrj4Mw8d1Xd4m70yLAC4PNFNFCTynIyRV8CiZyH/EoeQFF7T+5BPhrsireHyzZj/pKJk
         AxICtmXi4KIO7X4LqG6zFbhpq3ggj0Nr0ma4GDr8Cvy3JjkHJSrt04AjI0Ms350G1XDX
         3dy3nReIYcu/2Y7yUKft0FOx8iwLeXmA+8tVILSTnXr9anaM5VrYoOOXwxXo1fn6qbxP
         cBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe6x8AglcVXNM/Q/xgCrsELhOT6WdF8HMLMjTtnvl78nenT9obl3mxVBPljTyIG14e9nMzF+/z/zSrM3/rIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz83MGZfu+rPJzV8cMhV2DR7KCzTLyolplGNfePHJBohrK9hq7P
	F29f4S96hftg0QdsxD0FnnE6iooL23I3fjSC+HDojxSgQ8VwqiHuyHIZM0Dtjil8D7J4whw6MPW
	ROBdNVQFUo1EXwP67L5OO7d8RuvxuZZQV9C0l6aND
X-Gm-Gg: AZuq6aI8NrcsXuWNsGRw1mH45CUQOwDPORxzkcwjadAR0dmc4sBKERh4NgcovHyXiqz
	HqXhAc5f1RhR2MSSLfBNKfPvWYglnvSLrOoAvRuUv+46qLmmnM3JoGuZOlszEh+0QHm9C3J/T+C
	KxNtW02SQSX/wTMRWBt0ryOfH30VBLdXzPNS8tNY7VYLbSP4lM7UHOHCum85GKbO0jSNX/y0sRp
	nQx7hzNU7d1MsdmF31KLOz6b8D616TIxWWsVlBC2QJwDKCVjbLUgl6vr/pyRsaz/M85k+BQ4n/Q
	tlZRiNsmMf62FwSNTY3/3aRbiA==
X-Received: by 2002:ac8:5ac2:0:b0:503:4bc:c925 with SMTP id
 d75a77b69052e-503b68c5619mr437881cf.13.1769626369423; Wed, 28 Jan 2026
 10:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
 <ef6c415c2d2c03f529dca124ccaed66bc2f60edc.1769198904.git.lorenzo.stoakes@oracle.com>
 <47eafa10-6d13-4324-830a-2e7cf4e67f2b@suse.cz> <6444753e-1df7-4732-912a-0ea441f76cb1@lucifer.local>
 <CAJuCfpEBHsuGJFAGyXdASpaV_FY0_RBShKZM3QA_9z7ZvAtu6g@mail.gmail.com>
 <425e3040-0522-4af1-a7b9-c9ad04e017e8@lucifer.local> <bae98030-f359-49e7-b294-14aec5a5425e@suse.cz>
In-Reply-To: <bae98030-f359-49e7-b294-14aec5a5425e@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 28 Jan 2026 10:52:37 -0800
X-Gm-Features: AZwV_QgZBjbER74dI9m_uPvunquAKGJLY8LFOmekpfhxdXBjBkDVXkOvnrwg-7c
Message-ID: <CAJuCfpG4JLu88YKZuRzprMgL3ZvCS+wLaeGbG_O4pKboBXxaVg@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] mm/vma: improve and document __is_vma_write_locked()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 5:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/28/26 12:51, Lorenzo Stoakes wrote:
> >>
> >> >
> >> > Thanks!
> >> >
> >> > >
> >> > > Few nits:
> >> > >
> >> > > > ---
> >> > > >  include/linux/mmap_lock.h | 44 ++++++++++++++++++++++----------=
-------
> >> > > >  1 file changed, 25 insertions(+), 19 deletions(-)
> >> > > >
> >> > > > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock=
.h
> >> > > > index 678f90080fa6..23bde4bd5a85 100644
> >> > > > --- a/include/linux/mmap_lock.h
> >> > > > +++ b/include/linux/mmap_lock.h
> >> > > > @@ -258,17 +258,30 @@ static inline void vma_end_read(struct vm_=
area_struct *vma)
> >> > > >     vma_refcount_put(vma);
> >> > > >  }
> >> > > >
> >> > > > -/* WARNING! Can only be used if mmap_lock is expected to be wri=
te-locked */
> >> > > > -static inline bool __is_vma_write_locked(struct vm_area_struct =
*vma, unsigned int *mm_lock_seq)
> >> > > > +static inline unsigned int __vma_raw_mm_seqnum(struct vm_area_s=
truct *vma)
> >>
> >> This function returns the mm->mm_lock_seq.sequence attribute of mm, so
> >> no real commection to VMA. IMO it's better to rename it into
> >> __raw_mm_lock_seqnum(const struct mm_struct *mm) and have the callers
> >> pass vma->vm_mm.
> >
> > Sorry missed these comments.
> >
> > We are only ever referencing in terms of VMA's, so I think it makes sen=
se still
> > to pass a VMA ptr, even if it just references vma->vm_mm.
>
> FWIW I agree.
>
> > I think the name of the function also makes things pretty clear, given =
it's
> > called essentially 'VMA['s] raw mm seqnum'.
> >
> >>
> >> > > >  {
> >> > > > +   const struct mm_struct *mm =3D vma->vm_mm;
> >> > > > +
> >> > > > +   /* We must hold an exclusive write lock for this access to b=
e valid. */
> >> > > >     mmap_assert_write_locked(vma->vm_mm);
> >>
> >> If for some reason you need to keep this function VMA-centric, then in
> >> the above line please s/vma->vm_mm/mm
> >
> > Ah yeah, maybe if there's a respin? As kinda trivial thing, if that mak=
es sense
> > to you!

Ack.

> >
> > Cheers, Lorenzo
>
