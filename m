Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B1A38E5C2
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119394; cv=pass; b=YbNHPssHib3twIvnapMp9IVmVDcPhH6Fo2b0k7T5HvnELuTQ0ll1uApjSdm7wwzRiWid0G3h01pzbdIKFm3ThjwpvMtQRC9Iq8WoMe6TrKr3AbsgOcVTyhV9kUy/1T2KAsHpxaH5jdNcc+CWAqctHk9Q6oTaKmJCyS9WTg+K9EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119394; c=relaxed/simple;
	bh=iIk5N99xK/QJGN5TVBTfh8wwrKNMfEM3GYCjb7q0Yds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RC13ypXJOTVYkY17IYsod2PjwIq+/9q+srau9c6cBnZVmycMvBPeXyuQW9VubAAyHhwNX2c2SFYU490e7OTWFdhHh9DnTTnEACrvMUf1+hVHVIIQGoLSoPbuyBcuO0Cnm9q9m89OYOm61k/eYN6n2nRODuFn2cqGLni3TEOernk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1wp6QU5; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1wp6QU5"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50299648ae9so69631cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 14:03:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769119385; cv=none;
        d=google.com; s=arc-20240605;
        b=AUB7fZl2Vnu6qxV+PW863sE/RuXyt/BMiJmxv0QyeodjTNkUi/rpAX74afy/gF7Wn7
         5FvkGRNN9i4YSZMERtAhpRQ+ipUXjG4hw0wpHNNCVA6OM0RPtSyN2jN8VeYfFJf4jF5u
         Ak4kRpoiM/nGWIU7/U87jSy/GWiXh8BRtMJqPANddA48WAHoIgW0H9CszHGo+4M3XawD
         Rz7zvT8suDL0AGjXFLiwpcaviNeJ6UUBmlvMW258X4VrtKvlkyyHpg/wzZHBiij96GNX
         2yaizLo9dZaNioSB5+MS38/EkPgJlsznEJHPqLWvj9InyqUHI33COI8f+dYLZX7nGA0Z
         2h7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TUFswC7WALgWvhHt/vri/diAlr1YiuidCkTY+195eFs=;
        fh=eba7tnbPQEqH9tinAXsW0EZuFuJxNjay+7+ouB3W/A8=;
        b=OdFnbxF+90T33mJ2aG0/orqGe+UL52ji2CsyT8cZHWOFf0w9g/M0JKmNedbJZcHDPM
         9b6NI/uJh4wFreaMsB1oDWOjoOAQ+0kQWMh0fuwQKgf4/u09h3zMkr8cyRH00rB17BAB
         E6uxMSnsTlH0rnFlx6V7/1Wh/UjMZGyCHAAHfTYSQ/973Uw88UqstC20RqrXfvmPjJJk
         jSPO79H2k91IjSoqwWRXgN6EVVjqHXybX1U1807W8pXAJQzBsqElgNDi9rSWtux8+hpX
         s0oEOeiiCW5ES0K5DjZpkCTv4i356FRN4tZtEAhef+B9cNtyXotOFC/WGtCDfaWy4TlS
         0vzw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769119385; x=1769724185; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUFswC7WALgWvhHt/vri/diAlr1YiuidCkTY+195eFs=;
        b=Q1wp6QU5Jntsjbcsw5wxkHqA5CAlrgPeHIaX6s/PLVQ5pf+79/KN4/FYm+byKgYrn7
         C7ZxjRgLrkDbYQXAhf78rzVXsF0W9yXy43laPzSg8QUA05qELFVc8QMw5XfLmIKhGTf1
         npJcGrWXP41B/EejP6Je8Yh5LSSGIq4F6ywd7ShxIftjiUcyZBmtLl7BFy36r3e3kNGF
         HEnkOpXaUgp9kGN3rYf94k6e0U5eQMcXgngu+aP9xG6wopSIITawr6CMkc6+ujihgnCK
         Z/XBF41jRraqO/G5/SHxm9xVWJyFH2kHivAggPxt6uE4rZpvNv5XxuK8/olfZxU914ny
         1DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769119385; x=1769724185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TUFswC7WALgWvhHt/vri/diAlr1YiuidCkTY+195eFs=;
        b=LlDinyZ3UJ+e7YRr2hyae4YWRGSkDNgoWAFDJIZOO4Z7E315J+NCPSmh2zw20xQkJW
         pE+SjZe6b5s9thaGFl1AaLig5ga9iDWKik/jZYe1Te9u2P2YBxS0S+YBXkgLykllAlTY
         tB+esXiSuXUaxO9Gra2NyWI+vLtVj2+eJEv76O7GMThL+Jb9De+ngDOtj3hHYLaXzL3S
         nkNvzjvZhpeJwoXP/jpVY3rx/hNpoCvPpX1Oa7c8MEyIh3FdXJjspqJ2mwCe/xpPtLTk
         UjsGCzYXghm0NyiS84UmSVdkTqHLYjVzeb+rnU1uyy/dr4qW0xRqMr8483CGrNlfmBmg
         /z9A==
X-Forwarded-Encrypted: i=1; AJvYcCV2uC+/hLttM5dHqJm1vEYcxC1EzMrVWw8taOHtcohJAPzkhGq0XPc4zUvJ3GOxKx0ztOB/pS5Bkp67ihMPBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwggkXtmqeH42BVVJiZTrXcFogeHKrzUs4DG7P7ExcEUXxyEgdn
	sUizUxG4v0Obtp31G4l1N7+1L1pViMKGRfecF4LK1c5BI2S8/VzS+X7uHSbqkAHkFiyHTrHnIaq
	FkocdFFX4KCrAHAyCI+m/6vt2a1prC3ZB57DkuY2Z
X-Gm-Gg: AZuq6aI2ZrMIFqNZVkTJmnjophDCTjbxvF/bNsT1eChkQAEOJAn7kgqIq506jF+Ebiw
	h9JdE/7DDiza49mGXoBksRZVsOsSc8FLrvVRZICeslTVzhjVMhkmf/PfReipGnQLWuMzBnJhr6P
	YtEE0f/oYPzYIiSwTMdynSGD/5klJGoGXuajPIFAVOU35RrnY3OA1Ot173Upm1Oj4SYCZUsHdtT
	jy1QadUdPhjmVA6BscxiMz9wcPFGYqOfKK3lYjuNw9ATVYahcBwsfbmjmDDvz/CKZcEgOQWlygk
	RgId7oT9Lg9/WEacX8ZaXWmN
X-Received: by 2002:ac8:7dc6:0:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-502f8d571admr1046721cf.1.1769119384657; Thu, 22 Jan 2026
 14:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com> <fbaa0ab025c1f345e559df2b1045b223663806ef.1769086312.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <fbaa0ab025c1f345e559df2b1045b223663806ef.1769086312.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 14:02:53 -0800
X-Gm-Features: AZwV_QiH7uTftGNaxq_cn6-c5aA0bWdwkSr5uV6ZePFQF00zb8M9zgeuI3MJ7I8
Message-ID: <CAJuCfpG_5Do+Qajtnhbv9uK+BssDh7NpXYGzfbKBJGZgtiKF0A@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 09/10] mm/vma: update vma_assert_locked() to use lockdep
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 5:02=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> We can use lockdep to avoid unnecessary work here, otherwise update the
> code to logically evaluate all pertinent cases and share code with
> vma_assert_write_locked().
>
> Make it clear here that we treat the VMA being detached at this point as =
a
> bug, this was only implicit before.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks correct.
Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mmap_lock.h | 42 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index b00d34b5ad10..92ea07f0da4e 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -319,6 +319,10 @@ int vma_start_write_killable(struct vm_area_struct *=
vma)
>         return __vma_start_write(vma, mm_lock_seq, TASK_KILLABLE);
>  }
>
> +/**
> + * vma_assert_write_locked() - assert that @vma holds a VMA write lock.
> + * @vma: The VMA to assert.
> + */
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  {
>         unsigned int mm_lock_seq;
> @@ -326,16 +330,48 @@ static inline void vma_assert_write_locked(struct v=
m_area_struct *vma)
>         VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
>  }
>
> +/**
> + * vma_assert_locked() - assert that @vma holds either a VMA read or a V=
MA write
> + * lock and is not detached.
> + * @vma: The VMA to assert.
> + */
>  static inline void vma_assert_locked(struct vm_area_struct *vma)
>  {
> -       unsigned int mm_lock_seq;
> +       unsigned int refs;
>
>         /*
>          * See the comment describing the vm_area_struct->vm_refcnt field=
 for
>          * details of possible refcnt values.
>          */
> -       VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <=3D 1 &&
> -                     !__is_vma_write_locked(vma, &mm_lock_seq), vma);
> +
> +       /*
> +        * If read-locked or currently excluding readers, then the VMA is
> +        * locked.
> +        */
> +#ifdef CONFIG_LOCKDEP
> +       if (lock_is_held(&vma->vmlock_dep_map))
> +               return;
> +#endif
> +
> +       refs =3D refcount_read(&vma->vm_refcnt);
> +
> +       /*
> +        * In this case we're either read-locked, write-locked with tempo=
rary
> +        * readers, or in the midst of excluding readers, all of which me=
ans
> +        * we're locked.
> +        */
> +       if (refs > 1)
> +               return;
> +
> +       /* It is a bug for the VMA to be detached here. */
> +       VM_BUG_ON_VMA(!refs, vma);
> +
> +       /*
> +        * OK, the VMA has a reference count of 1 which means it is eithe=
r
> +        * unlocked and attached or write-locked, so assert that it is
> +        * write-locked.
> +        */
> +       vma_assert_write_locked(vma);
>  }
>
>  static inline bool vma_is_attached(struct vm_area_struct *vma)
> --
> 2.52.0
