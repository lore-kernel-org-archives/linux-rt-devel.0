Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0879142E73
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Jun 2025 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749711821; cv=none; b=VAeiHj1Zkg3iEI4/5APwAraT+gmyGaYe3jf3fOEVowhdpACa24OH+fDSch73TQjEC+xAFxSJ5Ew/bY3L+VIsWn41mYXWUtZwe6E3LbbEQYYJQgTq7GzOwoMGC3lYjjGdKhh24GEQRXHZlQVRo+1zDzP3kk2eQ65OsQ4UwG1Fubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749711821; c=relaxed/simple;
	bh=jcZDLKqbqjAfKbQedgUODPcuNZG2Ql2waANaGALBD0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rC1dEudVR1WfzuF+LWFpn0jdKIBSmMOUOeexbJQos3yXewzw2IWGKEJT4/K+l23fqQYxiKQjO2zsmjTFNkZpxPja3+9N+nirAy7pLBB3P6MZpnNqoXSeMjzucCh8J1O3+KoxozBCPoMIgAHCy4+TfSWGJIJ4X7yrVWfqfZHCKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgNzqeyx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgNzqeyx"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3109f106867so951926a91.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Jun 2025 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749711819; x=1750316619; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2viZ0fvQanFU5qt8YT35F/R2lomO19AjWDbbjNosEQ=;
        b=bgNzqeyxu0G4vKjey5DsKyVimRHoxebRC7NX0Jt0tOET72pv5bpMNOaGtl0SIillVC
         KG+JxPLsCs/98GEB82Ak55ZJSGokBuGcqktQ251ju0SptfiTcS07stKl9akOuPrzzgYQ
         e//YSyrMZ8X005O7l8TufJ1aEdyjsJCU24dJC8biuBk612iSVh++bwWMgBbMsFZd1i0Y
         dOUIir1aBjUUDldyuXH7hcSxbmfMwBFfE3l5Xb3DvhJSDkYMSePc6s9pGEsw/NwYzQ7/
         gRlKhOECbNpSLePkfsaXRyrK38U0qUs7qHG1sstqTFqm+fPfFf4eBJ/zDT7NWg9Sz9NW
         yMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749711819; x=1750316619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2viZ0fvQanFU5qt8YT35F/R2lomO19AjWDbbjNosEQ=;
        b=wCnf49bqGzS59D6m4vLRvuBECYt9F/SJseBbjQUQvWlmmcE0EtkEFwrKGnjoHPAfpK
         lsRqohlDqM5Ofcyur53vkO0OUaJ3DjVWwpcshFBRTjgJSX8L5Gtr6OEnRdyGoUgVYX7w
         qyYw8OGdFbedrfQ6Ezb5v4qLrQP//KIlYvebCuBRg8UrBqM9AXRqjh0U5RkMMptlVoNw
         Kw0PGWN9eFIwBBrhT7P8SAYitorMqsBxMfJrqWDp31FG2reif3LEaFW+gif0jhn4aJ5f
         JAsILln6XEai91GSghTf2TPAACk8FAhl8yeObTN9E+vRHQqVL2TMJPUPgeZN75HvRGGI
         Yqqw==
X-Forwarded-Encrypted: i=1; AJvYcCXXh1KBuLjvuBm0al+RhRnTP7uY0+6ayE8NbiDKomzV+vBpw1ZZgWafldXGkWBLq9c6PYPufnZt8dxxh7sgsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJI+XbsIhHS7eujaD8TPMkrkf4vRqVRFl1fjKn5/cUJFsV1JrE
	9fccax4BHN17Yk41kX+19aPIO2ybAJ+8rm5eT91+bFte0knYM7HGUkjXHRYVb9EnLtDeyh78Vnp
	hxtU9oc8w9kgALnBCYud/1ArGPxcrbp0=
X-Gm-Gg: ASbGncvoys42zUyYTB+huU8b0srNBveI/7bofHBkCzAAVlJFHvDPL2EJtVegQiWggef
	/g4XM/uLRUZaxQr98i1n3Lvr3d4Y/IdOV0fDkBp1QQfDLApQxxiWiYuN0bRhvoMGoJTi+SX4MIG
	9d1TpOY6Ac8NZOyKgJghxgKG2y3ROFGf2Qa+5HJyNei1pQcUNdzPdYCIQ=
X-Google-Smtp-Source: AGHT+IENKZbG1UVgSxMkbsR683h8ZS+NANUj8qRCEWN4KJPO/n5K8VlClSz08iFrHEgPCWpYK+IcgPjCIyzqEMtreeY=
X-Received: by 2002:a17:90a:d60c:b0:313:279d:665c with SMTP id
 98e67ed59e1d1-313af0fd099mr9895979a91.7.1749711819053; Thu, 12 Jun 2025
 00:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFGhKbwVyxCwYSNrPaQ-GkuP008+uvDg-wNA5syWLLzODCfpcA@mail.gmail.com>
 <68c0649d-d9b3-44f4-9a92-7f72c51a5013@suse.cz> <CAADnVQK+wjvxmBM7WJOGNK=AqeJ7UHBO4tUZR3Gjc4kfgux1sw@mail.gmail.com>
In-Reply-To: <CAADnVQK+wjvxmBM7WJOGNK=AqeJ7UHBO4tUZR3Gjc4kfgux1sw@mail.gmail.com>
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Thu, 12 Jun 2025 09:03:27 +0200
X-Gm-Features: AX0GCFvBcJwp9XkOkM0Sw3LXe5H0SSamdpy1Wp3lz3PcgPgcT0LbkH9Bh5kjWlk
Message-ID: <CAFGhKbwP9e6yWM615FGuq0=eX-57E-f813MMdXZ98D4_+0TveQ@mail.gmail.com>
Subject: Re: locking/local_lock, mm: sparse warnings about shadowed variable
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jakub Kicinski <kuba@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mi., 11. Juni 2025 um 20:20 Uhr schrieb Alexei Starovoitov
<alexei.starovoitov@gmail.com>:
> I wouldn't bother messing with the code because of sparse.
> Compilers don't warn here.

Actually, they do:

$ make W=3D2 mm/mlock.o
[...]
In file included from ./include/linux/preempt.h:11,
                from ./include/linux/spinlock.h:56,
                from ./include/linux/wait.h:9,
                from ./include/linux/wait_bit.h:8,
                from ./include/linux/fs.h:7,
                from ./include/linux/mman.h:5,
                from mm/mlock.c:10:
./include/linux/local_lock.h: In function
=E2=80=98class_local_lock_irqsave_constructor=E2=80=99:
./include/linux/local_lock_internal.h:100:31: warning: declaration of
=E2=80=98l=E2=80=99 shadows a parameter [-Wshadow]
 100 |                 local_lock_t *l;                                    =
    \
     |                               ^
./include/linux/cleanup.h:394:9: note: in definition of macro
=E2=80=98__DEFINE_LOCK_GUARD_1=E2=80=99
 394 |         _lock;                                                      =
    \
     |         ^~~~~
./include/linux/local_lock.h:88:1: note: in expansion of macro
=E2=80=98DEFINE_LOCK_GUARD_1=E2=80=99
  88 | DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
     | ^~~~~~~~~~~~~~~~~~~
./include/linux/local_lock_internal.h:128:17: note: in expansion of
macro =E2=80=98__local_lock_acquire=E2=80=99
 128 |                 __local_lock_acquire(lock);                     \
     |                 ^~~~~~~~~~~~~~~~~~~~
./include/linux/local_lock.h:31:9: note: in expansion of macro
=E2=80=98__local_lock_irqsave=E2=80=99
  31 |         __local_lock_irqsave(lock, flags)
     |         ^~~~~~~~~~~~~~~~~~~~
./include/linux/local_lock.h:89:21: note: in expansion of macro
=E2=80=98local_lock_irqsave=E2=80=99
  89 |                     local_lock_irqsave(_T->lock, _T->flags),
     |                     ^~~~~~~~~~~~~~~~~~
./include/linux/cleanup.h:391:68: note: shadowed declaration is here
 391 | static inline class_##_name##_t class_##_name##_constructor(_type *l=
)   \
./include/linux/cleanup.h:410:1: note: in expansion of macro
=E2=80=98__DEFINE_LOCK_GUARD_1=E2=80=99
 410 | __DEFINE_LOCK_GUARD_1(_name, _type, _lock)
     | ^~~~~~~~~~~~~~~~~~~~~
./include/linux/local_lock.h:88:1: note: in expansion of macro
=E2=80=98DEFINE_LOCK_GUARD_1=E2=80=99
  88 | DEFINE_LOCK_GUARD_1


$ gcc --version
gcc (Debian 14.2.0-19) 14.2.0
Copyright (C) 2024 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
