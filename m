Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6C255F2C
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Mar 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767805; cv=pass; b=VLoBo8MR8lhcPmfp6NMaYYTWxTduO1PrjuZA9LTOKmA58BGr0y4LgdRWNgmz8sb/0LnmQ+A1TWN+mld8N5m7XtAF84rQfGvV2ou4yhqp6wyy6Vaat8ueXDUKRS1qKM8DSfgrBLCBTGK6FmJ6L6dpEzJe96VeYblA1WQNiIO5G2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767805; c=relaxed/simple;
	bh=sNoN/Xh8CUgNjwW3bTkJAIWBkTvsjLmibZC6m+YJO2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEA6k0SdQvUMsQgZLDYNZzikpysy+DS82Jyw2Nuq+DK+67/SiCL+vNcBpGPQqmq6hfN7IlI7K9v04i8gBf9CmNoQLZWJtEqa1OiliKc8s5fCQpfOH8/NYtR1rG0GYUUnu19yg0RvoVQ01D3Xg8qmgUeu7EcHV7UnHqDK/6tZ4YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BABD2u4H; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BABD2u4H"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ad9fabd08so6733468d50.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 17 Mar 2026 10:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773767802; cv=none;
        d=google.com; s=arc-20240605;
        b=ia9GIuOj/j0qMCtnbFOdkKTLiauc6O380RiAmGl+zmrhs4Y+8KwpNJ6Ajkce226pdH
         kI0n/Ju0EZM/905TnCpCOk4tPNVhk1fZTEZSeR7u32YY/N3F3UaOGfgEudzcnwHp3wPa
         cmvZZyM2h4dH0MMU123r/G6rcEYM39n4x7Z5CLdYdMMDDJkO+YfoZqZeaaPU0ob6QZUk
         zPCzQSIFqNJMXgTwQBaNeYl9v6v2wk+i3AJj8z8gnh1o/8g/i37s7apC6wuO4IP04Bkx
         yN5rpUjZ+PIGBOfDvtUrVf3FYQ5HJZLwZEG4ojYRRUo04NH/1OfN7Tg2PpU6FAvYC3Th
         Euag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q2zAeBs9zo2lv0T0WIuTbdsujf/BJxEymoy13o+3BzM=;
        fh=NLzhvpV+xs+4Lo3bK+8PI/Js48cWjL3zeywHf1781tI=;
        b=XU1ebypVE5ehyRYJWncUQONQGwETxc0h+hXSTZ6MluWfp/Ee8f4wg4h0D/BhzNvSYQ
         mNs2pTSyuQ5XBkZPxBh0RYUadaKaY9qPdIvToLrC0EltEmfopR9EvYKwpErauqbgV05O
         RxnsFscc20Dwaq/8p6388EzpVMUamLxobw6pHj2Pkl4AzwdMTVL4H9Tq2mZ9zoyzfNHX
         Ox4vDYFNW2DIJfl2oizdKraFfQ0WF6GvjtLkptodP7XBln3var8XhS2rFrZyhSre2yD7
         76+pOqxmH/jaYaQSJCBVMCMH9iy8bi27GbOkmOtQ1WnXDmreZ5TKj6sERw5nyqX540ob
         ZIPQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767802; x=1774372602; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2zAeBs9zo2lv0T0WIuTbdsujf/BJxEymoy13o+3BzM=;
        b=BABD2u4HPcngQH4Lif2keUfT4JMTaBfI92HWKvjRrRhzb09w1mkUEjsAN1gEBopqXK
         gCaBZO4UlwyFlKKSaKDzLn2q6TWAbRHIMg1ZWvKvAqIzI9BsN5ShrMhcSfh3uq7sWXyc
         0l8MxsR6cBZmIJviPjACrpEUOsLWci3pb0sWa91YRUMi1Ukr74U9mpcGxWyUHyezQH24
         biLyJa8OT116Y/9iI8p++6ZbiIV1tHhzm8vqQ3TjgU11hFfmDABrkyCofjI3h3tkCLrT
         uVe4k/jEgnz2AmtfVgTAAZU7iVENkYnnmMa6aiV13dk5ydfrOGxaro0zSLzkVPL3Z2la
         RVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767802; x=1774372602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q2zAeBs9zo2lv0T0WIuTbdsujf/BJxEymoy13o+3BzM=;
        b=iE8xld+sfSy8sHPS2HYl5rEciRLGF2HWSX1lXMSpD0dZAf42WwmzMoOyWwPTcocOgX
         wFHEIy97wPDSeyJ9pDoAj08eSNd4RRxRaVoYvpoFce6rBUWbu72sp10hXy6MiJQALfQZ
         TbVG6ylkz9TDy5iVPU1CvcP01/cxG+/cmUvyeg9v5MrcADmBgQmjTjvlh04qIdGtr6JN
         kpcalrHok7llrd3WPzerMjbVM9YWzn3KNgO/ps8AhC1LLVj9XlQVeXERufTuqcGjF9by
         cN8DEuumdldNJehPdph/d1F+RDLd3CiuWtwYYVSj4Ohu6InaJQa0DLYHzy22hIstPZX1
         dQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnf1P+0cuMsLgux2u7vJCyHsqRzt/ChA+f4Zoi3AKER+wtjV0tfbUY2X96DSoa5pLuKlQib9fPIG4/0lorxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YywxmSWrkx8KedMP0Wmx0KMChLmTvcAFjdnYGr3Zp/xybUhyuBt
	W1XRH7fxevb6r7vZpHv8PfI1EgdNMo8/6lwmY10vY+EFg1VXuwr55iVDizXbfnjR/uFYh22f5K9
	JIWBFEfAVzFoSykiWQqp8DCgdmMsjuzY=
X-Gm-Gg: ATEYQzz8RgaDRMTmxZfF/6ZlU8rUa5gmyGe1OIcrY3gVIyw+PQowbY/aTSWHMac7dE6
	5b3tiiXWhm33Q65JFf2Bhtwq2XxpkQHGDcqeMKN3wdP5l52IegTBP9Uu5f1exjNy8UKlFnQw/mh
	DpLq7PW03F8yFTja1wxqtmNPMuQLgRnQpHix994c/BhVFHMmZFB6vlMH2F4z853LFnu3yX7XvGN
	+BXkaQc3fp/budOJ31ROSBGXVE8EfsmNVNam4zFv+2w6oZvwRMTkrOnY72RrRFS4hyJ8kx4cjAt
	VGfVNO2xnSCQUj6oY0tU
X-Received: by 2002:a53:be4b:0:b0:649:b31e:8f4e with SMTP id
 956f58d0204a3-64e91619389mr343424d50.70.1773767801490; Tue, 17 Mar 2026
 10:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
 <CAMB2axN9xYPzAJVQVywx3sxYa5ViRxt2oktt1LFXsSD_XsuJrA@mail.gmail.com> <SY0P300MB07691E08E5283FE074C81BE2C641A@SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB07691E08E5283FE074C81BE2C641A@SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 17 Mar 2026 10:16:29 -0700
X-Gm-Features: AaiRm51gOU8njsC2VoBSF2OL4VzOChb4st-LR63ZRP8xg4-IJKtd30ho-twlx18
Message-ID: <CAMB2axOw_qZQ2ksTPSVb7LqAGv1sxjA9u+EyfE8ygd4Rxa9BGw@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when !HAVE_CMPXCHG_DOUBLE
To: Levi Zim <rsworktech@outlook.com>
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

On Mon, Mar 16, 2026 at 5:40=E2=80=AFPM Levi Zim <rsworktech@outlook.com> w=
rote:
>
>
>
> On 3/17/26 3:53 AM, Amery Hung wrote:
> > On Sat, Mar 14, 2026 at 9:02=E2=80=AFAM Levi Zim via B4 Relay
> > <devnull+rsworktech.outlook.com@kernel.org> wrote:
> >>
> >> From: Levi Zim <rsworktech@outlook.com>
> >>
> >> kmalloc_nolock always fails for architectures that lack cmpxchg16b.
> >> For example, this causes bpf_task_storage_get with flag
> >> BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
> >>
> >> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> >> But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
> >> for correctness. Add a comment about this limitation that architecture=
's
> >> lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
> >> bpf_local_storage_alloc always fail.
> >
> > Let's not do this.
> >
> > This re-introduces deadlock to local storage. In addition, local
> > storage will switch to using kmalloc_nolock() entirely.
>
> I noticed the PREEMPT_RT case needs kmalloc_nolock for correctness and di=
dn't
> disable kmalloc_nolock in that code path when !HAVE_CMPXCHG_DOUBLE.
>

It is also not correct to use kmalloc() on !PREEMPT_RT. A BPF program
in NMI or tracing kmalloc internal that tries to allocate memory for
local storage can deadlock.

> But in the original series [1], It appears that switching to kmalloc_nolo=
ck
> is purely for performance benefits and not for fixing deadlocks in local =
storage.
> And I didn't see any "Fixes" tag in [1].
>

There is no deadlock issue with BPF memory allocator and
kmalloc_nolock(). For context, the patch you are referencing is part
of a series of refactoring to
- Move from BPF memory allocator to kmalloc_nolock() [1]
- Remove percpu busy lock [2]

Please refer to the cover letter for the motivation and changes made

[1] https://lore.kernel.org/bpf/20251112175939.2365295-1-ameryhung@gmail.co=
m/
[2] https://lore.kernel.org/bpf/20260205222916.1788211-1-ameryhung@gmail.co=
m/


> Could you provide a more detailed explanation? Thanks!
>
> [1]: https://lore.kernel.org/all/20251114201329.3275875-1-ameryhung@gmail=
.com/
>
> > For riscv hardware without zacas extension, I think a workaround with
> > some performance overhead is to enable CONFIG_SLUB_DEBUG and
> > slub_debug options.
>
> There is a patch [2] that enables HAVE_CMPXCHG_DOUBLE for riscv so I thin=
k
> it will not be a problem for riscv in the future, even for hardware witho=
ut zacas
> extension because the kernel has fallback implementation for zacas.
>
> However, this would still be an issue for other architectures. Currently =
only
> x86, arm64, s390 and loongarch have HAVE_CMPXCHG_DOUBLE in 7.0-rc4.
> I don't think letting users enable slub_debug would be a reasonable worka=
round.
>
> [2]: https://patchew.org/linux/20260220074449.8526-1-mssola@mssola.com/
>
> Best regards,
> Levi
>
> >>
> >> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_n=
olock() in local storage")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> >> ---
> >> I find that bpf_task_storage_get with flag BPF_LOCAL_STORAGE_GET_F_CRE=
ATE
> >> always fails for me on 6.19 kernel on riscv64 and bisected it.
> >>
> >> In f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_noloc=
k()
> >> in local storage"), bpf memory allocator is replaced with kmalloc_nolo=
ck.
> >> This approach is problematic for architectures that lack CMPXCHG_DOUBL=
E
> >> because kmalloc_nolock always fails in this case:
> >>
> >> In function kmalloc_nolock (kmalloc_nolock_noprof):
> >>
> >>         if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
> >>                 /*
> >>                  * kmalloc_nolock() is not supported on architectures =
that
> >>                  * don't implement cmpxchg16b, but debug caches don't =
use
> >>                  * per-cpu slab and per-cpu partial slabs. They rely o=
n
> >>                  * kmem_cache_node->list_lock, so kmalloc_nolock() can
> >>                  * attempt to allocate from debug caches by
> >>                  * spin_trylock_irqsave(&n->list_lock, ...)
> >>                  */
> >>                 return NULL;
> >>
> >> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> >> (But not for a PREEMPT_RT case as explained in the comment and commitm=
sg)
> >>
> >> Note for stable: this only needs to be picked into v6.19 if the patch
> >> makes it into 7.0.
> >> ---
> >> Changes in v3:
> >> - Use macro instead of const static variable to avoid triggering
> >>   warnings.
> >> - Wrap lines at 80 columns
> >> - Link to v2: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v2=
-1-576e33e4fa67@outlook.com
> >>
> >> Changes in v2:
> >> - Drop the modification to the PREEMPT_RT case as it requires
> >>   kmalloc_nolock for correctness.
> >> - Add a comment to the PREEMPT_RT case about the limitation when
> >>   not HAVE_CMPXCHG_DOUBLE but enables PREEMPT_RT.
> >> - Link to v1: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v1=
-1-24abf3f75a9f@outlook.com
> >> ---
> >>  include/linux/bpf_local_storage.h | 1 +
> >>  kernel/bpf/bpf_cgrp_storage.c     | 3 ++-
> >>  kernel/bpf/bpf_local_storage.c    | 4 ++++
> >>  kernel/bpf/bpf_task_storage.c     | 3 ++-
> >>  4 files changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_loc=
al_storage.h
> >> index 8157e8da61d40..d8f2c5d63a80e 100644
> >> --- a/include/linux/bpf_local_storage.h
> >> +++ b/include/linux/bpf_local_storage.h
> >> @@ -18,6 +18,7 @@
> >>  #include <asm/rqspinlock.h>
> >>
> >>  #define BPF_LOCAL_STORAGE_CACHE_SIZE   16
> >> +#define KMALLOC_NOLOCK_SUPPORTED IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBL=
E)
> >>
> >>  struct bpf_local_storage_map_bucket {
> >>         struct hlist_head list;
> >> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_stora=
ge.c
> >> index c2a2ead1f466d..cd18193c44058 100644
> >> --- a/kernel/bpf/bpf_cgrp_storage.c
> >> +++ b/kernel/bpf/bpf_cgrp_storage.c
> >> @@ -114,7 +114,8 @@ static int notsupp_get_next_key(struct bpf_map *ma=
p, void *key, void *next_key)
> >>
> >>  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
> >>  {
> >> -       return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
> >> +       return bpf_local_storage_map_alloc(attr, &cgroup_cache,
> >> +                                          KMALLOC_NOLOCK_SUPPORTED);
> >>  }
> >>
> >>  static void cgroup_storage_map_free(struct bpf_map *map)
> >> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_sto=
rage.c
> >> index 9c96a4477f81a..a6c240da87668 100644
> >> --- a/kernel/bpf/bpf_local_storage.c
> >> +++ b/kernel/bpf/bpf_local_storage.c
> >> @@ -893,6 +893,10 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
> >>         /* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
> >>          * preemptible context. Thus, enforce all storages to use
> >>          * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
> >> +        *
> >> +        * However, kmalloc_nolock would fail on architectures that do=
 not
> >> +        * have CMPXCHG_DOUBLE. On such architectures with PREEMPT_RT,
> >> +        * bpf_local_storage_alloc would always fail.
> >>          */
> >>         smap->use_kmalloc_nolock =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? t=
rue : use_kmalloc_nolock;
> >>
> >> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_stora=
ge.c
> >> index 605506792b5b4..6e8597edea314 100644
> >> --- a/kernel/bpf/bpf_task_storage.c
> >> +++ b/kernel/bpf/bpf_task_storage.c
> >> @@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *ma=
p, void *key, void *next_key)
> >>
> >>  static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
> >>  {
> >> -       return bpf_local_storage_map_alloc(attr, &task_cache, true);
> >> +       return bpf_local_storage_map_alloc(attr, &task_cache,
> >> +                                          KMALLOC_NOLOCK_SUPPORTED);
> >>  }
> >>
> >>  static void task_storage_map_free(struct bpf_map *map)
> >>
> >> ---
> >> base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
> >> change-id: 20260314-bpf-kmalloc-nolock-60da80e613de
> >>
> >> Best regards,
> >> --
> >> Levi Zim <rsworktech@outlook.com>
> >>
> >>
>
