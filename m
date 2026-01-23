Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC6A239E9A
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190177; cv=pass; b=oZtlj4CY6EYuZY8QVSnK5sTmu+JySdxTMw2/dcQmagLUvN7NqEAY1YH8X8JJWPlwXZ+vMdiIqEO4mDa17O0X1GQa1HbZmJS4JTXEMiJ+FwkUNlHy7vodLP1/vBIE3B2qFy69bElOrliizUDshXrepjVs/FlYVAu/RqRhXY9Cqo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190177; c=relaxed/simple;
	bh=e+tsB72F3JGE1Sv1wNW1iQ2Epj5tsNldF6c4BC1mHJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QC6KtA0KLAG6B2GJmkCTWveFHwuROodT9eAzrc7YH610J/0q3UEqU+d9Dozut3uIYtysUG/UNpdyZUaW316VFZrCMwILH19wIbm4980iJAEBIO5BeWpMYTLyusxhc4xvvZqHELLaEYhDTZjVtoOKnZVnVKSzXT0IbqAMfXE2VU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3SZLJ/TE; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3SZLJ/TE"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5014acad6f2so941cf.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 09:42:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769190175; cv=none;
        d=google.com; s=arc-20240605;
        b=kzspg4NcQx3sH/BqKw1T9P/oqIVgZosHaByk8zDAUv1nxbe2yqG9POWDIlOQI8J7PC
         w6gRfBHthiRXAGTS7nlehcS2YJHzoF+qCZS35N/sh00PnBgWEYVd+Qx6EaTievxSbzwr
         GcCIv/Uzwjl3GvOX5wVgFmvpeaE8JzwW9DvasmIv058oNmuM6DwjJGv7Y3Z10QSrvzu6
         FCQZEz2IwLs+w2pOVQbAiKZzmDU03ktrcDBqOtKeyVfG+O5Lx8n8DLf3apojcayeIBzm
         FFHZlk0soEto39KD40e8zjV5nNLgo9bC8LTK7/wtaFeFXt5q4wyH3OczsFKBiLkPhw0m
         jZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ecysJ6oY4A4ZF/nobL6khlSXSX0Rv2e+xk4Zdl2vm+k=;
        fh=q+FVUt9UdfkObJeNm5tfYohP1yeHpj2ilFwS+zx/Yac=;
        b=EHVG0+thCCsJ8P9Mzd6rWdrZZIQzkeY2XeLTU0Fl+SoAp8EvO4Ti9MuQi6RlwOCwAr
         2ExD/4R2d8lo+tKDo+xD10WJhzprcEx8+g+emEl6K/rWKoYYZ7rvn9In4DFCAfaXeSXg
         ve7Gpx8ZZWjXv3ws9tFjBLNPn3+an5wvUwavKJ1H7WexW90IvXFhyf733kKAleeq0XeV
         RkXDKJuLvl+FtPVTqOho/Eg43hLxRr7/JJZIEqsBO4kAUv33O6HLWoKnNZBc0rRacJAo
         GE7q9NGTVkSuqgs2P8a6EGQChZ6aik86sFWx8kjlhtt6+XZ/HD3mUUkQP5kUek/roICv
         hH/A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769190175; x=1769794975; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecysJ6oY4A4ZF/nobL6khlSXSX0Rv2e+xk4Zdl2vm+k=;
        b=3SZLJ/TE1d1nYbLjlw7Zgd2P9h/PSao7DQOIfICRbcDyGZ86LUzA9doQ22SGCMIaYL
         pvl25xBIQaH3QXSuNJCjNCoAg9NtCK1Rd+t5zHrGUtUTeGztkuysAYdjgVwXw+I7LhK+
         5htDiZSb6CDXNcKg83DsVuS4OYEEVOQHK+Cek9FtWWdL27288LDkszK0gwFAmsJeI6wB
         Djp9HgdKVc1vFToOuwljJeT6syUtHMlSkFxnNltDff7zd5jP+XFVcSKAtpR1GhIsPi0Z
         jPpP4oa6HIDdF2ZzjKigc0c3xXOcORcap2MXH9D06Q0LP726cYWNCzcqJ2vBBt10ZN7M
         RIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769190175; x=1769794975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ecysJ6oY4A4ZF/nobL6khlSXSX0Rv2e+xk4Zdl2vm+k=;
        b=L2IiYhW8pAJKlvObL87j4Aawb6LLJW15XYbqal1mTH95U7Jq5j8phcoE+fBk4P9w3q
         TSazvik1NRvcNqQWJ9z0wUPEJNgLvxy/iWuIpbvt7wcxle+kQS+cdzPZo/TSjygP4qLP
         ZiKvbmsWajav99PzcMxeAdDadEqid47Hk6NR+aEU97ef53kaZk0DqqAPcnIrKCw8HxZQ
         hy/TJXEDvGRtDO5mP2h6nTo+CMpzJ4YZczAMbBDJ+mtIzCrb34swgFvlo5f414yBDo3w
         qw3TT0dwgBezBdA/a5nFXz76TWGUZW338j+JTjPqmjMS92Vl2yjhaVentwKVp17a7OsY
         aCuw==
X-Forwarded-Encrypted: i=1; AJvYcCXAHLNVTV+cMUI99Fn5tKvqDEj6hfr6tF4QqYq8CojrOkpX/SkFLv8WELcRBNmKRRWNiDC6U7Tc5m79b3dwNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXj7q+gktjPpNnbsFa8A2Fn2mVYpbWYJ6L7hxq3QUuLt38e73R
	4wsGFRDGQFecTKEJCC7a9UHZ5/QItfpJnPyCSZ6b8ctUFgY1AndMEoOpRTxYmq/RelUHXmouaJ9
	7m4DE856EkXbvTCwI7V25RrAWvgL2n3xMWEmHygtX
X-Gm-Gg: AZuq6aJ1+kJRHswlAmzM5bwxAwOAkdlmG3bFkILDSOEUXygSZsDUkhzl8WdsmsZYiO/
	6EKhp6jrTwnYa19a9ec012VQQE7QD6yhcrrKkE3jZ9J5BJmqI0USd1ySmGLQ3RUsQbyOwuvxr9x
	Tk7lDdapflSfxb1u5T4RbYN0zNsoCoJF6GWUZurtDMIw/BZAsMTf4YYv/ozPD+/j4j73niYqj/K
	2E7yu5nTAdATSlLKlEwibC7CeQfIpG5euV08WFB3AhtQLEiSnqN4YDt2splo4aV9EYZWA==
X-Received: by 2002:a05:622a:15c6:b0:502:f1e0:dd3b with SMTP id
 d75a77b69052e-502f8dba323mr11741431cf.7.1769190174705; Fri, 23 Jan 2026
 09:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <70dcf80f79ecd00a750ea17101061b0949119429.1769086312.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpF1LthyP2FR4T8iDd+zOi1WAjqma2KBkHcCJsOjm+s32A@mail.gmail.com> <b267b699-f312-4387-8dc0-a14efe72561a@suse.cz>
In-Reply-To: <b267b699-f312-4387-8dc0-a14efe72561a@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Jan 2026 09:42:43 -0800
X-Gm-Features: AZwV_Qg0XqJp6LB6ClHaUtMVJzUsaWRJQOHROvVx-k5EXeTYGcGYUgT45CfCEsU
Message-ID: <CAJuCfpEo9XFFzGL3c-Udy+0GDM12xOtDeFxu2J4L7F-kQ7xohg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 08/10] mm/vma: improve and document __is_vma_write_locked()
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

On Fri, Jan 23, 2026 at 8:21=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/22/26 22:55, Suren Baghdasaryan wrote:
> > On Thu, Jan 22, 2026 at 5:02=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> >>
> >> The function is a little confusing, clean it up a little then add a
> >> descriptive comment.
> >
> > I appreciate the descriptive comment but what exactly was confusing in
> > this function?
> >
> >>
> >> No functional change intended.
> >>
> >> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >> ---
> >>  include/linux/mmap_lock.h | 23 ++++++++++++++++++-----
> >>  1 file changed, 18 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> >> index 873bc5f3c97c..b00d34b5ad10 100644
> >> --- a/include/linux/mmap_lock.h
> >> +++ b/include/linux/mmap_lock.h
> >> @@ -252,17 +252,30 @@ static inline void vma_end_read(struct vm_area_s=
truct *vma)
> >>         vma_refcount_put(vma);
> >>  }
> >>
> >> -/* WARNING! Can only be used if mmap_lock is expected to be write-loc=
ked */
> >> -static inline bool __is_vma_write_locked(struct vm_area_struct *vma, =
unsigned int *mm_lock_seq)
> >> +/*
> >> + * Determine whether a VMA is write-locked. Must be invoked ONLY if t=
he mmap
> >> + * write lock is held.
> >> + *
> >> + * Returns true if write-locked, otherwise false.
> >> + *
> >> + * Note that mm_lock_seq is updated only if the VMA is NOT write-lock=
ed.
>
> Could it also say to what it's updated to? Or is it too obvious?
>
> >
> > True, this does not result in a functional change because we do not
> > use mm_lock_seq if __is_vma_write_locked() succeeds. However this
> > seems to add additional gotcha that you need to remember. Any reason
> > why?
>
> Actually I wonder if it's really worth returning the mm_lock_seq and pass=
ing
> it to __vma_start_write(), which could just determine it on its own. It
> would simplify things.

That looks fine to me and indeed would simplify things... Yes, please!

>
> >> + */
> >> +static inline bool __is_vma_write_locked(struct vm_area_struct *vma,
> >> +                                        unsigned int *mm_lock_seq)
> >>  {
> >> -       mmap_assert_write_locked(vma->vm_mm);
> >> +       struct mm_struct *mm =3D vma->vm_mm;
> >> +       const unsigned int seq =3D mm->mm_lock_seq.sequence;
> >> +
> >> +       mmap_assert_write_locked(mm);
> >>
> >>         /*
> >>          * current task is holding mmap_write_lock, both vma->vm_lock_=
seq and
> >>          * mm->mm_lock_seq can't be concurrently modified.
> >>          */
> >> -       *mm_lock_seq =3D vma->vm_mm->mm_lock_seq.sequence;
> >> -       return (vma->vm_lock_seq =3D=3D *mm_lock_seq);
> >> +       if (vma->vm_lock_seq =3D=3D seq)
> >> +               return true;
> >> +       *mm_lock_seq =3D seq;
> >> +       return false;
> >>  }
> >>
> >>  int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_loc=
k_seq,
> >> --
> >> 2.52.0
>
