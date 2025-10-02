Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96F30F95A
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Oct 2025 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410144; cv=none; b=Lx6Hk1IZBDYqYW7rx1dPJ/OjhuzaU/WVRZCRg28ird+kBX69ZoiLobI1rQInrGBiw3yc38ZZCmd/Cq0SM47WofC4xzPRcFMleygStP7+XLMB6OgLcngZRIhNdoGYWnvn1XJcG123p0ZI5MdamvYZmrBPF74/30+5/t0Iy3anlRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410144; c=relaxed/simple;
	bh=Bzm3UVzy5UmWZcilLMKv+UlC3Okbitce2Is02Gaxtrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbKEW3L1E425xOEcsAjnpAnCbIxG8iKdTUj26GTmCsKKbq5N0oiG31O3xE8FGHUAqB3S7jY6+AV2bj387JuaMvpbg+zfMfU0DoTVQQVi0YKbfkkImcsS7Bgax3EG3lr1wV+Phz1/Z4AFyM/I8imI01re1UJeyVlMAgRKeOBcu44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-81efcad9c90so12528456d6.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Oct 2025 06:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759410142; x=1760014942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ec+ndxQ3jnu1a8VNviNr06HkWUDsCBC6MfDIjOmWDIU=;
        b=Gu7MAQhYK0emBE6LX9ATRRVpgAm9+qpHLGWaKXbmzAvL/qyQqHL66EzCi/uYQw74ht
         AEZIKhzJFrRWxCoGHqk59GYCJ8e6fGl8OPx8FSdwDlNic4nUXPc7YoOG36y0SkwDs2mZ
         NBexKwgiLSPBXnOANWzw3l1lzgpDkwi9zVZbueILK/xllEiZPZnvSPFyBlDkwP1Q9kaK
         k++1Q6L3F6WnycYUq11u2m0iqq7KhNBDVYKT3nn7blHqxYv/rwFdTxEQolTRumQKiDQ7
         2RrwnrcubgRbr5Nk5v0iRIBHTOVJ8uAm5Joo04M3dQnEFPBza1+MTN+KkMIuLSTTsHlP
         p+MA==
X-Forwarded-Encrypted: i=1; AJvYcCXMgqoDG9Rig+/00WLwj1bQy7u6oxMYpSsm0ockKc2+dy1D5iz9i9dvztLxBlfvt6kiv5YhghNXdDT+QBr0qg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7MORxoWtcvio/cT8cSfYnul9C3VCoWeqSLP1DSZcPfL/kn7/4
	XUqA342R33XOC7CbD23JvLX1KlawLqHHxusjA28BZxH9xtBup0fpLD5dOaI0Dy/buKIhgg==
X-Gm-Gg: ASbGncvFtfRYT6nSaZF/h66zLjczOLg1+WJgV5oyPS8PmrblnFaReebNVlvyfiC4naR
	b/awFaZpTAXvCN3FB4N5yG+kgE9tNj2hP/5wJc9osU7owHyEVdkFW68dcIy1BXcTdGt70HwKWE9
	HqzzOY5k45ML7MvXEU+yWN88XlPSpVO1KkDpXnXGj9UVVEst+K0ckKg2XqHGW4jdQsBdtYvcr+m
	D2fNm9rUzkgDWNhHj1BTPCVQCaxBGRiZDaG6ydUMK1QURc9YrbknNQE4CQ4VfIy+uCTiMNHbjL5
	4ojqV41Hru88rhb0aQq82g9bRcOmjByZ4paiKwjDfWzfYRV4CIyA7/pAbrdD8J5KMPzktafZprr
	wNufu1AkSTQBVPAYisuMWbeIQJjUB1Ndlri8ZQlrnbVode3TqeZ1uCk9BlZOGryUWOscEkLjHBx
	/tHGOUKL7pN49wGHd7cV0=
X-Google-Smtp-Source: AGHT+IF1wfguHdionekhr37SL1AJZ7dt5ET+awJt10kBOsh3mL6R2yUj9SMzhDulOVC6UHVNNeZnDQ==
X-Received: by 2002:a05:6214:2427:b0:794:463c:6d26 with SMTP id 6a1803df08f44-873a77f771fmr102072426d6.60.1759410141375;
        Thu, 02 Oct 2025 06:02:21 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd7867b0sm18312006d6.37.2025.10.02.06.02.20
        for <linux-rt-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 06:02:20 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-81efcad9c90so12528216d6.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Oct 2025 06:02:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXShJ5BTH8t+2c1RpoZBafsKV2vO43abUVnjEztDGprkOSlgQyDko4cf93OUjALW8O05PDHS29IfFY2JGYmzA==@lists.linux.dev
X-Received: by 2002:a67:f74a:0:b0:5d3:fecb:e4e8 with SMTP id
 ada2fe7eead31-5d3fecbe643mr2057033137.5.1759409779799; Thu, 02 Oct 2025
 05:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251002081247.51255-1-byungchul@sk.com> <20251002081247.51255-3-byungchul@sk.com>
 <2025100255-tapestry-elite-31b0@gregkh>
In-Reply-To: <2025100255-tapestry-elite-31b0@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:56:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
X-Gm-Features: AS18NWCmqHU8DKNueQjpF6Ifrv2W5fzYfUTjQ8XBBt-1KrFWqeUHHsvmYo_0fpY
Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
Subject: Re: [PATCH v17 02/47] dept: implement DEPT(DEPendency Tracker)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, 
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, 
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, 
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com, 
	kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org, 
	vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, 
	cl@linux.com, penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, 
	ngupta@vflare.org, linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, 
	max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com, 
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, 
	corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	sumit.semwal@linaro.org, gustavo@padovan.org, christian.koenig@amd.com, 
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, 
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, 
	urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, 2 Oct 2025 at 10:25, Greg KH <gregkh@linuxfoundation.org> wrote:
> > @@ -0,0 +1,446 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * DEPT(DEPendency Tracker) - runtime dependency tracker
> > + *
> > + * Started by Byungchul Park <max.byungchul.park@gmail.com>:
> > + *
> > + *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
> > + *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
>
> Nit, it's now 2025 :)

The last non-trivial change to this file was between the last version
posted in 2024 (v14) and the first version posted in 2025 (v15),
so 2024 doesn't sound that off to me.
You are not supposed to bump the copyright year when republishing
without any actual changes.  It is meant to be the work=E2=80=99s first yea=
r
of publication.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
