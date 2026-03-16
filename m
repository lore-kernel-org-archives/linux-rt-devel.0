Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273E3ED5B2
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Mar 2026 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690820; cv=pass; b=TUm6LvGTcZ2KI2rw/mfB1Uwn79ql2kF6wcorAw8PAAGiebHilodqCaTQGcvU5HBz/Mfdg9wn05yUH17smpVaIIZ3hbYFjq/GlxSF5UFqOTYHg2TVxZZO6Na166vDNZ9AlV47gbjXJaB0wLCA3SNGlSLx0d8RMz7dQmrFVQ1g62A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690820; c=relaxed/simple;
	bh=VY7/ARQ274h4uKfie1OktnCkIxcE/wgH7GGSyqdtydE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7zQKzZkXczCDoA2ktcR09RsCXLgKztEDS5h7dOsA4an1r2fkEI5FQOOVmMeXRm5GyRKZqxPDHff/DN3edtP5TJULDL+ytX4xcnz5Juz51CgZbYCvptShUfhHoZ0iMFh7S0o724dqKwS2pfcWOu0FkMZPnrL0dedqJDcMAEU95U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9rbHGtB; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9rbHGtB"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a535e7c00so12415127b3.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 16 Mar 2026 12:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773690818; cv=none;
        d=google.com; s=arc-20240605;
        b=NO5UywL175+Z39fEQzvbApZIJ7kdVe7ulkcCljD16QYkpqGXRckBbQXDTM1dW2JP3/
         7shjFqFUIBfdXtbmp15q/cLnf7qRLo11JuvDDetlS/Rr7Lp87JPevzzPCtDH9oDu0aaE
         zgNkHZZZYqGVNmCSB1EM5f7m3IXN3jiGQZP4rZPdi1Z4VR7M2QJcJ+iavX/QncWH8vNl
         d93aDdCsjnzij4TVmvNZattXQRXLhLBnlJSvd9xJWOh36VPNYeG5+Z+1zZX+kiHPnfof
         21GAxiLNsxMdhRLN9hl55uT1wJCqk8AYhlA8EhSTozVMRG1x5ug3w7nqIeF0Rkxotosx
         sRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cfr/+KdWaNG7d26GP7p0CvuBKTKufLHHRbtv8HCrcI8=;
        fh=xpjjveuZDT79XHnyeGZwMDMM9rf8NldDrMINwlT1nMc=;
        b=e4jfOcgijAE++xGdnf2BVeK94yiJNBxAGmD1n7zJ0JgmHG3FhjgYEXShQs62tcT6+s
         vlb4wf6uo2p4LudI8z914AW6fIMda5/LvREwCk6Ftw4GTYRu9612tdwKS32ljGQlpwzg
         8ZHyPQZ9HmJlmtCPsmFYvSQFQORKBLJoY+HWYWdFZPPYZw2t6FV9833geXtL8EHPNwTy
         LhqIomfo5SlbisH+XkGFUj1WrZabz371Jcm3QL7P1qHNVgcKAv2vhi/T9oiXefSdo/5s
         MBnrU0DGpwcsULXUoIfcS9h1bX25W+Ux06er3Pfm+8pRPdhU1DDXt8bVOApqvD1JtCu8
         EBJg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773690818; x=1774295618; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfr/+KdWaNG7d26GP7p0CvuBKTKufLHHRbtv8HCrcI8=;
        b=N9rbHGtBhR4hp+GphvQaUpZdOQaDC6dHNPyZlNmxULEDC8mnYfVSu4/DVOTZRaEDFA
         +6uNCu+Y/G7j3++K7Ldd0xvnG3S/Nuoy/45chkDoudxUS5cjA8OA0tkrjTZFODuiXO1H
         9UJLbjJGsIUGz+lD3Uuq4sAQEYACPNEpEv7PQ/xMX7rPqzf9ZaVcz5V4RnNaQBXh1MDW
         c4nDX8drvALD4UTl1wMuMt6PVhwLVyxZsPCPPaa+4aZJNy1OQV+EnXGkvRVb4MAx/6c1
         EzXIBw/6xY09WrtXeDKjPJgTmzpVwbl4cuyvAxtBXRnjf1WVQRj2omgPX/RzApRTeutz
         UkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773690818; x=1774295618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfr/+KdWaNG7d26GP7p0CvuBKTKufLHHRbtv8HCrcI8=;
        b=k5m3aXBiZNt8JgWDTt7MZQf3lcdRy+xH+Qac5hgWmqD4HVTB6aVUQDjTptOtNYZ+kb
         Xz47Ua2O4+pHjlV3ImWIdEi4Jcv3EaSvFme1bBfYOVGqax3al2BGqh4augJ4sHpMVhGi
         AP5dx9Z6ta0YeoKpYbVdbV6wiv6QKc4+FZ1LICduqIXNmKkf5lewanwS9fYKhGqgc2Jn
         AyZNYmMD1DXFzKvrWhKi9TM8iKM8ix6qA9z3rZX96vizvpCM/R5i36/y0vY04lLkFvKy
         kpATZfHyevEJYe538vVNus/MpeENl3tdSrs//i74BN6YjWy8MjZsQm+pyB/mTUYPZrDw
         j+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWlmYtJK5/72zQF80RolY1vwYOv5a/SuoXBtFx+H98vWWPlkBgm2wT02HJcB2zn8dA2bAqiP+fFf8dlE+QFQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZwkP+E9eK5FnwDdBeNCA72trCkqq278wBeGQHMGmYnRaMgoKk
	1X1sX/QeKw+4w+TwJQiijkkjGhH+WTjJqo4Sv+NCcDBUD6fFEsdQLKpOC2RzjVA61zcbrpHrbmc
	giDnEr0Fmv1AGbzDl34NXzhxMkPQBXeo=
X-Gm-Gg: ATEYQzzw9Gp50PxiwHEGkw/YP8+jqM6/r1uMJY89HkcmGZZPjirGc9scSTIH3mixV+6
	GsqZSOklfh6+f4LRHNfStJtR5xRPZDbYeA5hTmcqIzLXKgRmeP8nMSVG9Nx/PR1f7Cm4VZMMlBi
	QjWfJIRUwANdfgktpgPMm2TWWb/HrREMepEAB3lH80ImB8+5IHUxusAgdgsnnnOfgSHAgC7g4j6
	ooXJEvAC826WAC5bzRp2gY0w4QX1Q/EsEvtv71B66fW/CY2V5hRS1wasPxZz53bNzvmlEDEqemo
	LwtrpAOqUKKaw3WTsfsgchU=
X-Received: by 2002:a05:690c:6c0b:b0:79a:4317:395a with SMTP id
 00721157ae682-79a43175384mr64466277b3.2.1773690817924; Mon, 16 Mar 2026
 12:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
In-Reply-To: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 16 Mar 2026 12:53:27 -0700
X-Gm-Features: AaiRm51TRiU_TdEe_xqQj-pB0MImfrzcDdg1WNNiYNlT_5xOuouk70K7fxXMtb4
Message-ID: <CAMB2axN9xYPzAJVQVywx3sxYa5ViRxt2oktt1LFXsSD_XsuJrA@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when !HAVE_CMPXCHG_DOUBLE
To: rsworktech@outlook.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, stable@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 9:02=E2=80=AFAM Levi Zim via B4 Relay
<devnull+rsworktech.outlook.com@kernel.org> wrote:
>
> From: Levi Zim <rsworktech@outlook.com>
>
> kmalloc_nolock always fails for architectures that lack cmpxchg16b.
> For example, this causes bpf_task_storage_get with flag
> BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
>
> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
> for correctness. Add a comment about this limitation that architecture's
> lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
> bpf_local_storage_alloc always fail.

Let's not do this.

This re-introduces deadlock to local storage. In addition, local
storage will switch to using kmalloc_nolock() entirely.

For riscv hardware without zacas extension, I think a workaround with
some performance overhead is to enable CONFIG_SLUB_DEBUG and
slub_debug options.

>
> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolo=
ck() in local storage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> ---
> I find that bpf_task_storage_get with flag BPF_LOCAL_STORAGE_GET_F_CREATE
> always fails for me on 6.19 kernel on riscv64 and bisected it.
>
> In f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock()
> in local storage"), bpf memory allocator is replaced with kmalloc_nolock.
> This approach is problematic for architectures that lack CMPXCHG_DOUBLE
> because kmalloc_nolock always fails in this case:
>
> In function kmalloc_nolock (kmalloc_nolock_noprof):
>
>         if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>                 /*
>                  * kmalloc_nolock() is not supported on architectures tha=
t
>                  * don't implement cmpxchg16b, but debug caches don't use
>                  * per-cpu slab and per-cpu partial slabs. They rely on
>                  * kmem_cache_node->list_lock, so kmalloc_nolock() can
>                  * attempt to allocate from debug caches by
>                  * spin_trylock_irqsave(&n->list_lock, ...)
>                  */
>                 return NULL;
>
> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> (But not for a PREEMPT_RT case as explained in the comment and commitmsg)
>
> Note for stable: this only needs to be picked into v6.19 if the patch
> makes it into 7.0.
> ---
> Changes in v3:
> - Use macro instead of const static variable to avoid triggering
>   warnings.
> - Wrap lines at 80 columns
> - Link to v2: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v2-1-=
576e33e4fa67@outlook.com
>
> Changes in v2:
> - Drop the modification to the PREEMPT_RT case as it requires
>   kmalloc_nolock for correctness.
> - Add a comment to the PREEMPT_RT case about the limitation when
>   not HAVE_CMPXCHG_DOUBLE but enables PREEMPT_RT.
> - Link to v1: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v1-1-=
24abf3f75a9f@outlook.com
> ---
>  include/linux/bpf_local_storage.h | 1 +
>  kernel/bpf/bpf_cgrp_storage.c     | 3 ++-
>  kernel/bpf/bpf_local_storage.c    | 4 ++++
>  kernel/bpf/bpf_task_storage.c     | 3 ++-
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
> index 8157e8da61d40..d8f2c5d63a80e 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -18,6 +18,7 @@
>  #include <asm/rqspinlock.h>
>
>  #define BPF_LOCAL_STORAGE_CACHE_SIZE   16
> +#define KMALLOC_NOLOCK_SUPPORTED IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBLE)
>
>  struct bpf_local_storage_map_bucket {
>         struct hlist_head list;
> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.=
c
> index c2a2ead1f466d..cd18193c44058 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -114,7 +114,8 @@ static int notsupp_get_next_key(struct bpf_map *map, =
void *key, void *next_key)
>
>  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>  {
> -       return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
> +       return bpf_local_storage_map_alloc(attr, &cgroup_cache,
> +                                          KMALLOC_NOLOCK_SUPPORTED);
>  }
>
>  static void cgroup_storage_map_free(struct bpf_map *map)
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index 9c96a4477f81a..a6c240da87668 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -893,6 +893,10 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>         /* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
>          * preemptible context. Thus, enforce all storages to use
>          * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
> +        *
> +        * However, kmalloc_nolock would fail on architectures that do no=
t
> +        * have CMPXCHG_DOUBLE. On such architectures with PREEMPT_RT,
> +        * bpf_local_storage_alloc would always fail.
>          */
>         smap->use_kmalloc_nolock =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? true=
 : use_kmalloc_nolock;
>
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
> index 605506792b5b4..6e8597edea314 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *map, =
void *key, void *next_key)
>
>  static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
>  {
> -       return bpf_local_storage_map_alloc(attr, &task_cache, true);
> +       return bpf_local_storage_map_alloc(attr, &task_cache,
> +                                          KMALLOC_NOLOCK_SUPPORTED);
>  }
>
>  static void task_storage_map_free(struct bpf_map *map)
>
> ---
> base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
> change-id: 20260314-bpf-kmalloc-nolock-60da80e613de
>
> Best regards,
> --
> Levi Zim <rsworktech@outlook.com>
>
>
