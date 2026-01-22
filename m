Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4483D3010
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118944; cv=pass; b=nXXRdUaYHE1yiVx8C5xQyZAMyYiE3bSNjzFppJSN4ckCg3BLvDuwKXa7Y7pmYLJ0X/u53gJxExWtHp6Za+cXk4WMSBm+RFzCeYUzaOquIEvOmZwqIHxWNOtKSgabkl+vXdC92NBx317WFWL9wZ7HL0eQHijdzXTC9WxaJEw7bLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118944; c=relaxed/simple;
	bh=C2dSAu++ep+Cos6NB5v+8vhijqoPc3JZBTZJS8bFj5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAMe4KEBbOEsgpCtadEOjR4/I4bgFqUMriqOHKaiF6bC7jx23nU5lt6q+ZQKQzFNbNZH3pld0CNoCBXg5dkkLpZ+TjH/+kZa/GQG0iNxexD8nC7UXr7LF9X+XjhKzl82nXNrWRvfvJTn9raNUTMGuh0+SK2nZgX2GkDXSAM/mW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFrExJmQ; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFrExJmQ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5014b5d8551so186581cf.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 13:55:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769118930; cv=none;
        d=google.com; s=arc-20240605;
        b=dX/d8eoNZml4KUa/SWdTG6TSGhnvAjBSZrJPnszpcQUeY5alTQQH5QaPTHpko0mKu7
         IDpdOGbAvM1kyeeSeTBRjjXoWMjsCGOkCk9sHeZpVHEOTGRYR+xEZa3qM4IJn4tcgWbb
         TOMs+1mDcXchIFeOHsKJe/0ls9h0ll43r8xcV2nfzKgTfxWNdYtyNrZn7K3x47WymhCn
         oAsr28Oq4cG2o/+Ms9l18McxX6eoslICKr6ppXJIR74hdg1uEjimO5IYXo7zIrM99FX7
         rRGKa6ivyLXuLrs7MxcNCrti9m9cykC/JsiGAWITneydo826ExkuhMuuIpC73cIJgcM/
         K1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d073vIjiyMQqqIhnhMU9GQH3rRYcsGAX3Wwsgfbic2g=;
        fh=eito+NjAmjluzXiuhH+4aa6BjPCObOF+9KsH3wqJ56o=;
        b=RAggxlKqM4++NdvCnmZa8KJxMCPS62zP7wqh1lKqW0bEZFbt4J1ckTytMF3jJU5wD6
         RgusCK2tX+6mIgJWNXJl6jQaXo8VzNJt4J5umQUm/cqRctajfjugDdDw3TsfN4UBj2dj
         HbaTtkfIqqHTR9x6gbUi722VKS9O37TMG7dTTrFnLcaHOuoFLTqwRKYuNpNvkB/tidRF
         ARzF/kewvvMBIw0DSSTH3JqKPWsSdjuWCZeqg46rpMo756pxL2294+IvNL7IcQASwBII
         BVesvEPjqhm5rBWRYrIm1Edy0BmNLm2ynW03n/OZhdFf22J4GS4w1XMxcigbo6Uwg1ye
         2gnw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769118930; x=1769723730; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d073vIjiyMQqqIhnhMU9GQH3rRYcsGAX3Wwsgfbic2g=;
        b=GFrExJmQIAl1kGMwfSBuKcid18P3KRJuWKO3X9y639LB53L4jYYw8Ha4LyBiWn5Jsr
         Oq10nqmk9B/HsgVRSltbSF1T0KBwycu+/ehFH0ZjP7Ii+3+ZaCPUQQaFUjcQt1Se8ahU
         oS4ohEg2lnUUQXeJPCh4IudJLyf12DTx6qNJtgHPkzs+6gMOkX8il0SXan7PXcTtz2s5
         ihHiGW8flcaT7nrEYGcwL5eLfvfCfcthhZupSjXvPV50To7gdxdpYFF3HVbczbMZ0Y67
         H5YtoklAlO/IH5I4AV+Tdb4BfHu4nvpZJEYjVINIjQCXyEMcmfp8jCU6TOgdtV8MpOQs
         HX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769118930; x=1769723730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d073vIjiyMQqqIhnhMU9GQH3rRYcsGAX3Wwsgfbic2g=;
        b=ZN+bs4p7rMiNBmlizCLkLtdxoyPmHXwAA0mj3kYE1Nt5K+rHnkkUHAsWwpH8b9Alc3
         YYXIklOTG1pLftJFteZQPFCS1b03ysg8iRHWmNzv8Ex7EGeHUsXRskkR4rUMR20foi/0
         p00XoBegGvSEOvFxAzFvKMN0Etn54j3qQRL5imnSN01df3kq+/vtXzZ9CnErxm5ECvXC
         mYfBnd/MBE9U30s3uzvnRTHiNawFZwC+BYeETgzassarZeW5BncgW+CGKywVpfznjGDv
         X8iBa43MVT4TvimE4RxlAhva6ZuMFp5m7n2WUy/QtIETy1Sc8gS03pzUo4Shk26VSWAw
         6/ag==
X-Forwarded-Encrypted: i=1; AJvYcCXy4mHUxGYmmhMt9aysOhzeeA/Ly3LQs1WgWMldUNq1p6y2r/8b1n8p2HlYynhgbJ3ofRMKmFDDrAgGU4if8A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw54z6bz5splZzQJnX2e0Wnq4WTiRsruhw2dKOWm2jxNHKEIwkO
	3w/BdpWKUNX6E1Db2dOTP+e7jW9r27ptholHfIT5V47zmgGvzp2kDXhpWmK5DKufptyh2/VOPYJ
	R8wXCXCi5nuMos60bVBkmcJ1W7HAvhxZqmdaAtGBz
X-Gm-Gg: AZuq6aKcJJNSqLq0vJhZ+ui7jKqHdI7kb7fQOSQTQ6QvtzYtRuXrthlUaMPJrVpCtC4
	E5/6l46f+69NcpREaVXLegnaFrMGqs32lR96VVN6qCbfVtAk90swAxxcg6PNRxg5NgYE8Yxegdr
	5uJFmxVtCEwA3z3jIl6e2Sx74vvRRwG1ZFRhXbfjJsZrcwEA6mRxT66IWOKM1YIa83rq7C1YB+U
	uwIcBCYaByDvvyKe1GDOLoavcQSbtvs+BkXyMZ9/8UOdzeH70ebPUsMzMi1GLAowBrKxIlb62sY
	v7h/xRmpPJuY4McA9QCZY0Vtkoyge6VO0dI=
X-Received: by 2002:a05:622a:94:b0:4ff:bffa:d9e4 with SMTP id
 d75a77b69052e-502f8df02b7mr835541cf.13.1769118929938; Thu, 22 Jan 2026
 13:55:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com> <70dcf80f79ecd00a750ea17101061b0949119429.1769086312.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <70dcf80f79ecd00a750ea17101061b0949119429.1769086312.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 13:55:19 -0800
X-Gm-Features: AZwV_QinqaDgDNGKTqn3OPsVIG7-oCO5uUdRG2R6faYgmu8hZbcVs5vP3ybOn7I
Message-ID: <CAJuCfpF1LthyP2FR4T8iDd+zOi1WAjqma2KBkHcCJsOjm+s32A@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 08/10] mm/vma: improve and document __is_vma_write_locked()
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
> The function is a little confusing, clean it up a little then add a
> descriptive comment.

I appreciate the descriptive comment but what exactly was confusing in
this function?

>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mmap_lock.h | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 873bc5f3c97c..b00d34b5ad10 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -252,17 +252,30 @@ static inline void vma_end_read(struct vm_area_stru=
ct *vma)
>         vma_refcount_put(vma);
>  }
>
> -/* WARNING! Can only be used if mmap_lock is expected to be write-locked=
 */
> -static inline bool __is_vma_write_locked(struct vm_area_struct *vma, uns=
igned int *mm_lock_seq)
> +/*
> + * Determine whether a VMA is write-locked. Must be invoked ONLY if the =
mmap
> + * write lock is held.
> + *
> + * Returns true if write-locked, otherwise false.
> + *
> + * Note that mm_lock_seq is updated only if the VMA is NOT write-locked.

True, this does not result in a functional change because we do not
use mm_lock_seq if __is_vma_write_locked() succeeds. However this
seems to add additional gotcha that you need to remember. Any reason
why?

> + */
> +static inline bool __is_vma_write_locked(struct vm_area_struct *vma,
> +                                        unsigned int *mm_lock_seq)
>  {
> -       mmap_assert_write_locked(vma->vm_mm);
> +       struct mm_struct *mm =3D vma->vm_mm;
> +       const unsigned int seq =3D mm->mm_lock_seq.sequence;
> +
> +       mmap_assert_write_locked(mm);
>
>         /*
>          * current task is holding mmap_write_lock, both vma->vm_lock_seq=
 and
>          * mm->mm_lock_seq can't be concurrently modified.
>          */
> -       *mm_lock_seq =3D vma->vm_mm->mm_lock_seq.sequence;
> -       return (vma->vm_lock_seq =3D=3D *mm_lock_seq);
> +       if (vma->vm_lock_seq =3D=3D seq)
> +               return true;
> +       *mm_lock_seq =3D seq;
> +       return false;
>  }
>
>  int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_s=
eq,
> --
> 2.52.0
