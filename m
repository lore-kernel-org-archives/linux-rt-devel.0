Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1536607A
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110795; cv=pass; b=YdTIz9mTx1CpolZEecaUoZxkVWWRUnD66ZNgGYq3QNGFaOObpwwrRG/jeU0zqmxkQ6fFBULczH8pwxfa49YsOXdmUTDLFhoRzcD/pZTjdUIDqRJEElBWnRg3/TqgPRC1qjMPo6XGpdIh24iSGft9d2M+YNQnOeUcRhBxmuBtDT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110795; c=relaxed/simple;
	bh=LZhD0AvkU63bzwDocueId4Z6wGdSSIvLp3dHEFF2J5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLROiICA9uk4kSOFIA2BQYAFI55ixUzGjXvBqfXrE7ibr8qMcVmj8ql2DXdwY0ebRiyn0+QY4UkH/qcTjRAzWuXrn1Yp94EMahEkyBBbF6srCJMxKhofvLCYHny17Qo47umcJNS5L9RORJ75gOq/cjEiex4XGTOXiSyP4Tn6ETI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehx7lIGd; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehx7lIGd"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50299648ae9so43361cf.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 11:39:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769110786; cv=none;
        d=google.com; s=arc-20240605;
        b=OM3t32vVorveRTRQh0F3teuKT86rnaTsRkreH3O1yl0tqULZGkfP3YIZkC79C1T5jl
         tMiCqXx5hprItxkRYJqLYy0sI2YMn9u1OPdTomIBfcZioW38Q8jVZoE17QI1+CQiv8te
         B2Kopb1deweOm0VQu41eoLbCFyHe+hyoh5S+NVfgk4GIbU96G4d35Wxi4Nwl33Rb6fLa
         7SrPP9CrpP69Vg5RfafA5N9TdegPvUMmTt8M2usnWLd5kJNua2FEmaiQaaJif8SXMAN1
         ReCEQ2BnN+cnHkvqT5D/VSal/vdiKHqWl+9IbfDhEjLNYYmUSgydnPWwtoZIftOFFdAG
         iJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FbXrFJ0fbRQV5M77+5bXTD1xfH71g5LG/AxIH0V558A=;
        fh=xpUDACwGbVbSbfOmtlARgUTIsUQWjNHvDVtBmHbQOuc=;
        b=H+hRUGglhr01RsMc/zAvVQK0WYHd00kVDnoiQ8ylYtikjem2X8tET6FwIB1PsKM+7F
         l9fkJX4uZvXjEJYj21/gUZbCTsS9sl57U0avl4i0AjbbRO3eItimp+iyeP04hpkIoWD4
         5nqmrFqE3zY9mQKULa0eoJjz3m8kp53Rz2LeZaMKERPrc231MJ/kLHvwfp+MJJlyZk58
         sC/m1taeTzTQBhFTLNBcoseDUy2qLahsFb0nDucJy3H4mDw1yWK4dGWS/i0xeQK2oO9H
         MR+cM3Nn9qLRxRNCCg0VLtIcTvFkxbhl44dm37KGbg34M4GWDevqiEGKOtc2g1J6vWpm
         3ueg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769110786; x=1769715586; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbXrFJ0fbRQV5M77+5bXTD1xfH71g5LG/AxIH0V558A=;
        b=ehx7lIGdCPQYcU27UUkIDDqPBDcM2S87LbYhETaUmZDC8r0SmyE6Jnva1Tyi+nSuwS
         yMaNbW5zxFPThIpIunau8hbcrwUpjAVLUIcslTZ7RmArerRAwfF4v8Nc0k6VhgKHZA4D
         0YjbV6jNVYQ25XxchvGZUERObk1B3Z5ydwOVGbhEnp3X61ffdomXFAL9kM2Y+A0z/osC
         arW4GTo7oFTxnBJkQtChpa8A/0KK/UeDIE3AhCTb5YVRpkTSm/pH3HIg8TCx48+ACg9h
         phWW5f59tksTc782e6gXi99D4Io3PgFiM6fMRKqi24OoElipa3uJkxm5ISkuzdK1c5sP
         fwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110786; x=1769715586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FbXrFJ0fbRQV5M77+5bXTD1xfH71g5LG/AxIH0V558A=;
        b=ZvZ0DsXdXqni2zQxy9jtDBMICrK5PNhyl4ePnvLM17AYN3gGRSJNlIrzTMsqHyebVi
         hOPnsTsd8F/IoQK+pRsykvQ64QuLrmCNXBFYmxGpa++HAieTzdjVci/tjQB5g32FCmJ9
         PauPerlgDi6yZII+FZ2jnXxFEcCayXr7J8aW3b08ufcvqFbl1zcU5y6ePunjuIEMd7Pi
         cdCMHd342RNL5IhgsMOqebH1o6DDa1aQvS3HzzjbokJWMD+czn+z2pD8dEPQzSfJzlq8
         xqHgmra/HWoKeTlsNUJinmCWlS4KXFbi4C89Izn9ZOCvskjsmzndyUrSZenfpFE1dyhr
         oxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpm2wkz/Ijz/vrel7D0mqQtRAf6ahqf50Mlr14Xhmv2tLCxiQ4t5VW+BEN1x9/bv5LCkdL/C+VnXwUjDd9VQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRSjJPeta9aTYIhxfMfVLsSCGbnGSNDPFV2RLCXQPVhtERxzBa
	+9L5hQKZiYdHyExwUAj6N4Fgm62c3BiqMnrB23e+Ei1rczIyMDLzghpZyhnRNvE7tqrQCpwkuwI
	3Olw08c7g91axM6xry1XZuexqVjQPQa52kMh5Tmwn
X-Gm-Gg: AZuq6aKUSJ/AKXdNEAEQQw5ClDeIEBth+MJ5De7pHVKiJPvOXk2htNXe/i6lfJWpB9u
	e7d6azNaXSnBieBUOqSSY/9CGZrv2PuddGeV62uAxZ03J/L4sj1gccpn5lmVzCTAZwMT+Ryls56
	kOtSvk1iXza/BuNfvkeZ27vGq2WNGVyyNNN2lD8iXwr38NdtsR3tRHPpjEGxDwFtuzGe3aXkzpB
	kX7woP0lOsuOoRRvv3B5TAZ5/04tC5rPFQ59EGGkgnL+IbFEgbp98x1XeYgSMg26L+ScTHBeSqs
	KsNiiIfoU3QFgeTTeoE9dzYB
X-Received: by 2002:ac8:5f82:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-502f80e7440mr1370691cf.3.1769110785523; Thu, 22 Jan 2026
 11:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com> <2611b2b6957b7aef587e9ae62712a888159dce60.1769086312.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <2611b2b6957b7aef587e9ae62712a888159dce60.1769086312.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 11:39:34 -0800
X-Gm-Features: AZwV_Qh6PNOVoCipXXRRGwgLnWMjxjJqYBHLgvVtO7OcfwK79_FWKqPDx6CCM90
Message-ID: <CAJuCfpEv+aag1s2Aa=moCueyfB38hmSJFJ4ieZwthRdsKZEhWA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 05/10] mm/vma: de-duplicate __vma_enter_locked()
 error path
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
> We're doing precisely the same thing that __vma_exit_locked() does, so
> de-duplicate this code and keep the refcount primitive in one place.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/mmap_lock.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 9563bfb051f4..7a0361cff6db 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -45,6 +45,14 @@ EXPORT_SYMBOL(__mmap_lock_do_trace_released);
>
>  #ifdef CONFIG_MMU
>  #ifdef CONFIG_PER_VMA_LOCK
> +
> +static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *d=
etached)
> +{
> +       *detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLA=
G,
> +                                         &vma->vm_refcnt);
> +       __vma_lockdep_release_exclusive(vma);
> +}
> +
>  /*
>   * __vma_enter_locked() returns 0 immediately if the vma is not
>   * attached, otherwise it waits for any current readers to finish and
> @@ -77,7 +85,10 @@ static inline int __vma_enter_locked(struct vm_area_st=
ruct *vma,
>                    refcount_read(&vma->vm_refcnt) =3D=3D tgt_refcnt,
>                    state);
>         if (err) {
> -               if (refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG,=
 &vma->vm_refcnt)) {
> +               bool detached;
> +
> +               __vma_exit_locked(vma, &detached);
> +               if (detached) {
>                         /*
>                          * The wait failed, but the last reader went away
>                          * as well.  Tell the caller the VMA is detached.
> @@ -85,7 +96,6 @@ static inline int __vma_enter_locked(struct vm_area_str=
uct *vma,
>                         WARN_ON_ONCE(!detaching);
>                         err =3D 0;
>                 }
> -               __vma_lockdep_release_exclusive(vma);
>                 return err;
>         }
>         __vma_lockdep_stat_mark_acquired(vma);
> @@ -93,13 +103,6 @@ static inline int __vma_enter_locked(struct vm_area_s=
truct *vma,
>         return 1;
>  }
>
> -static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *d=
etached)
> -{
> -       *detached =3D refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLA=
G,
> -                                         &vma->vm_refcnt);
> -       __vma_lockdep_release_exclusive(vma);
> -}
> -
>  int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_s=
eq,
>                 int state)
>  {
> --
> 2.52.0
