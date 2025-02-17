Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628561A5B9F
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Feb 2025 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739833030; cv=none; b=KeUaRk1fW54lHhVXI6z5ALvA4wMoNL0HVoV3RKz648EX6BfoGh1m0DqvUk4yKWA26flvTAjKQQ8cRs6jq4qHMsLAuqGTUO9uUIyqDOg6UbtR16xWTUZV/YhjtQZ4RbhaeuxSOz6ViclGmfxbIyVOLjWerNbx9GywU0Vrd5zqTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739833030; c=relaxed/simple;
	bh=K4l0UzGmC9y3WC9pjmffsyw/t6wfshFgymcZNBGFgN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IShHdgASLz2ZESRh5r9/CuGrxqg1cIFX850LiX/GR3SC6nqKph9SJfhSGmm3ZLCn8ekiLGxoLAXASwU98u+ZKZhgX8tqKz+RTZTM5XNGPuyLvhT9BESTKTSVjd9zjAGlSKKxeh02UalItKgI1Qw717a7IBu0BqXbpiy+egVHPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8z0M0Wo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8z0M0Wo"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso2561910f8f.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 17 Feb 2025 14:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739833027; x=1740437827; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0Pzx9XFyMoQwaq/j01KSTY/+B12ar50FlSTQ8at2Kc=;
        b=O8z0M0WoQEsu9ARDv5oMsVlnmwsFe0ymOFQXg8mKX5o7DgemrssR22rsc3MiWMWPCx
         pQsWBf5v92SCWJCFbw6/jiOQO6CzBK5hORWAjGSB+wyNTS5a1ryCs+Mo4w5847TUt8oV
         nrlmaHwaCYbUVW7WOObBmY7Vwzq5GPfzWwRLwQKej60rI+cWxBzwYiokcElUulQNx2YB
         HEG+YVXTd1gKranUroOkARBwLW4jyyXeZ9+lffz5Kq6ZD+CHvw93cDLG3oc/wV3XTLXs
         KdVUivVxswFQUGRmhwOFMTaBG07JG7WrP171h//xP+2GvS9Loe4oBwKGjVNnweh0ae6J
         zs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739833027; x=1740437827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0Pzx9XFyMoQwaq/j01KSTY/+B12ar50FlSTQ8at2Kc=;
        b=DncrXTzOpiU7QS8dBlcvgRW0iAXMOC6cJDN3WP1B+AOu19uc+A23uXjupGboYscjxA
         /yftoWjPKQDq3IAYv3XLOKAvfFzemjK7I0eP9pOjgduLVVM3VY+x+aQf29MfNGlwgtDr
         pvjcVJtQac83RQdB8YpoxMA2qKSo5ytz9DR+aTxyUuezy+B5wBg/OLE13H8lzP7i4Lqa
         LksNm3ej87tsZVJlXPas32hZWE8K5GJ9FgyZSduXIWoHdL/w+A6XAvOYDsPO9AsQeFkF
         52YG0nuU2Ki7YkLVSmLz7Aa6OKWMQmZDSXkCFr6jcNXIMqTy/iM3v7AiO2TFcxTt6Ggs
         XaBw==
X-Forwarded-Encrypted: i=1; AJvYcCUd5ikPhgcaVzx+a4PMVsDYg8ECQXjpLI60s97mzfqd7OQM3XGYJ2Kxn0gRFvuuOpJN/lTzjv+p6cEf5US78Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3zQ/i50x8BCjOYhtk5NsiI6mF82uvLcWEU08/hjlomBTIvG6I
	jzJaFX7vBNBHxKoYhfc8YHImL19rpqvS+TfWqun+KICicH90CnnMqTmH0bA2oTBGOiEPFmJEQ/J
	4w/J/G2GLk47vwQynRQ5HnKRpHERXqE5f
X-Gm-Gg: ASbGnctf7PTEDB2o1geDZ4FgtTYxdGZWUNMcJgWermLUH8BBZ6EcDODH15KVlfTrG2P
	G/ZwnfzJ8fndB8vX6LKaELOtCpWQQODeRttd06td2zCz0niesBt4p8mJmEKp15j5NcLRE7VqsbX
	E=
X-Google-Smtp-Source: AGHT+IGybFvLWtxMVt6CWfv9HGPQQHrOMgU4/EA+mLEw5ZxQDNlqsMte/xjHUZsgZdgs8/zG/a05yUv4LsD1+YgesEY=
X-Received: by 2002:a5d:468d:0:b0:38f:2b34:5004 with SMTP id
 ffacd0b85a97d-38f33f4e2aamr9008909f8f.38.1739833026353; Mon, 17 Feb 2025
 14:57:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250217204402.60533-1-longman@redhat.com>
In-Reply-To: <20250217204402.60533-1-longman@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 17 Feb 2025 23:56:55 +0100
X-Gm-Features: AWEUYZmSmtSFKImfOr51DZheaPH7tbwA6sqeu5erz96SBLmh7o8z1iWhPYcqCvY
Message-ID: <CA+fCnZf3JbTUErHm_AG7r-dMD_6BmMctPAOaFAJQNH4k2Ev+dQ@mail.gmail.com>
Subject: Re: [PATCH v4] kasan: Don't call find_vm_area() in a PREEMPT_RT kernel
To: Waiman Long <longman@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 9:44=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> The following bug report was found when running a PREEMPT_RT debug kernel=
.
>
>  BUG: sleeping function called from invalid context at kernel/locking/spi=
nlock_rt.c:48
>  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 140605, name: kun=
it_try_catch
>  preempt_count: 1, expected: 0
>
>  Call trace:
>   rt_spin_lock+0x70/0x140
>   find_vmap_area+0x84/0x168
>   find_vm_area+0x1c/0x50
>   print_address_description.constprop.0+0x2a0/0x320
>   print_report+0x108/0x1f8
>   kasan_report+0x90/0xc8
>
> Since commit e30a0361b851 ("kasan: make report_lock a raw spinlock"),
> report_lock was changed to raw_spinlock_t to fix another similar
> PREEMPT_RT problem. That alone isn't enough to cover other corner cases.
>
> print_address_description() is always invoked under the
> report_lock. The context under this lock is always atomic even on
> PREEMPT_RT. find_vm_area() acquires vmap_node::busy.lock which is a
> spinlock_t, becoming a sleeping lock on PREEMPT_RT and must not be
> acquired in atomic context.
>
> Don't invoke find_vm_area() on PREEMPT_RT and just print the address.
> Non-PREEMPT_RT builds remain unchanged. Add a DEFINE_WAIT_OVERRIDE_MAP()
> macro to tell lockdep that this lock nesting is allowed because the
> PREEMPT_RT part (which is invalid) has been taken care of. This macro
> was first introduced in commit 0cce06ba859a ("debugobjects,locking:
> Annotate debug_object_fill_pool() wait type violation").
>
> Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
> Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/kasan/report.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
>  [v4] Use Andrey's suggestion of a kasan_find_vm_area() helper and
>  update comment and commit log as suggested by Andrey and Sebastian.
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3fe77a360f1c..8357e1a33699 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -370,6 +370,36 @@ static inline bool init_task_stack_addr(const void *=
addr)
>                         sizeof(init_thread_union.stack));
>  }
>
> +/*
> + * This function is invoked with report_lock (a raw_spinlock) held. A
> + * PREEMPT_RT kernel cannot call find_vm_area() as it will acquire a sle=
eping
> + * rt_spinlock.
> + *
> + * For !RT kernel, the PROVE_RAW_LOCK_NESTING config option will print a
> + * lockdep warning for this raw_spinlock -> spinlock dependency. This co=
nfig
> + * option is enabled by default to ensure better test coverage to expose=
 this
> + * kind of RT kernel problem. This lockdep splat, however, can be suppre=
ssed
> + * by using DEFINE_WAIT_OVERRIDE_MAP() if it serves a useful purpose and=
 the
> + * invalid PREEMPT_RT case has been taken care of.
> + */
> +static inline struct vm_struct *kasan_find_vm_area(void *addr)
> +{
> +       static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
> +       struct vm_struct *va;
> +
> +       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +               return NULL;
> +
> +       /*
> +        * Suppress lockdep warning and fetch vmalloc area of the
> +        * offending address.
> +        */
> +       lock_map_acquire_try(&vmalloc_map);
> +       va =3D find_vm_area(addr);
> +       lock_map_release(&vmalloc_map);
> +       return va;
> +}
> +
>  static void print_address_description(void *addr, u8 tag,
>                                       struct kasan_report_info *info)
>  {
> @@ -399,7 +429,7 @@ static void print_address_description(void *addr, u8 =
tag,
>         }
>
>         if (is_vmalloc_addr(addr)) {
> -               struct vm_struct *va =3D find_vm_area(addr);
> +               struct vm_struct *va =3D kasan_find_vm_area(addr);
>
>                 if (va) {
>                         pr_err("The buggy address belongs to the virtual =
mapping at\n"
> @@ -409,6 +439,8 @@ static void print_address_description(void *addr, u8 =
tag,
>                         pr_err("\n");
>
>                         page =3D vmalloc_to_page(addr);
> +               } else {
> +                       pr_err("The buggy address %px belongs to a vmallo=
c virtual mapping\n", addr);
>                 }
>         }
>
> --
> 2.48.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!
