Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A3F1D5CDE
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Dec 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735219502; cv=none; b=s0Yyor5428Uk+iSwOxUYtcwNLEo8mK5Fab3SfYxsEY4y0z+7OX/c6ZP89Wm/2Y0pdQN/cM/MjZg1pfXC5ouuHNj53i0IUPNpnsrRtxko8RmgTLvPpTplxA0Q7wgRqtoi8KwyuWEqKl+eZvcjwd3ywongl14JlCineACBxydWmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735219502; c=relaxed/simple;
	bh=fzr/y0By52LMwmidEnSfUqA91KlKWxY1fKTryC75b/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QF2xNpbsyHAHNeOQy/ilHYvHd5JMQcFbBo383vtx3GDKUMA/dBE6N08DTCHUgLVaxGCPvj6aaInzc7vHQUcHkDtEBl6cvG5jit2aLCe3AJkg49QPduiXyqL1XSwvnPfzwlQTjlAaOfWl2b6bIdg0/rGD5Be/5EfGJy33wdswnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=benAjKuO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="benAjKuO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735219499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XT1lRnhXlXD21/E0zejBEol4+u5gRnt3P8KO+08FkPg=;
	b=benAjKuOh5aus8FUs0TvUeNCudM6CLarZcxTehHSvDrdZKU9N5dCzjfDgkmIHWjkX4EuIy
	GUsK/cHdlMdr3RiRN5o7MXuI4hmRb1KPMgh54SxgCP2es2SsMJn7sdaAEiQf39cZEUfBa6
	qeahJ+BxrwR0CFWfChF8knTKvYnco6I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-ANp_eRl6O6uCgck9jMY43w-1; Thu, 26 Dec 2024 08:24:56 -0500
X-MC-Unique: ANp_eRl6O6uCgck9jMY43w-1
X-Mimecast-MFC-AGG-ID: ANp_eRl6O6uCgck9jMY43w
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso7982623a91.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 26 Dec 2024 05:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735219495; x=1735824295;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XT1lRnhXlXD21/E0zejBEol4+u5gRnt3P8KO+08FkPg=;
        b=KUtjM2WxV68UnZCGh+uUzSIUD9wu2id3RVtHJTOthjSKH3zS2jgd0OCrWxpfQQizcQ
         2KmO1p3iIgSY0lnRQxvxSEo1rfLEgXHx3BJhVQUYJF+A9U+47EZglZrYqSJBFxiZqUV1
         RTims+HtJmVid6DGDUvkfgJKDPDB4AXU8ysJvQ9AMMOd2Jpts98klDkRuAdvKpWjRP1q
         tg/cNhhbhkY4g44sYoDhTiFkwaoqemTQIcHr3AyypOILxFeuFWrc5BXWWGuwzpMeRe+A
         3TlHtdljQ/Koz4t8u76EjzZHtIFoNaIH094hAbpkYQFLT3tfq+QE9C1eiQLqxdkfKyXr
         eojw==
X-Forwarded-Encrypted: i=1; AJvYcCUCmqGHUfV/zguuDP1jDSCUB2tIWuET4GQ6gwJmk7HLg21QS9v/UQtAqgE1rlKM/UNsUNY43/w+iOAsR55nNw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+7H1DYxj6jDwR1ka6goCW4LDnS8Mrh+A1RSJJXAalb9PiR5tS
	O1P3JiHBRZwRaHEqToIIP5FLu3zsIptHarSAUgOaDS4LKT0qdeWB76WFLg9P+yJfNA2OdMdIguP
	rhY9HWwpfy+EG4+dOY/kazSXUt3OGvIfSnEaxw5i/YqMfiPC3OHKzEguSvSYAr6w9+LBpQaxLvq
	SVIjEAIqecB2ncxjRvpYluWyrMzAUUUWfdC8k0Q9o=
X-Gm-Gg: ASbGncvE21Z3Vjsxw2qFqeA6UCq/KgcbEfAvLINGrwS/2NoQdH2NaCICXyKpXxO1qWd
	I3oGgqxZccX11A/i4Iay3VNtiE+rVvOZR7Py2+A==
X-Received: by 2002:a17:90b:534b:b0:2ee:c91a:acf7 with SMTP id 98e67ed59e1d1-2f452dfccdcmr34514438a91.4.1735219495460;
        Thu, 26 Dec 2024 05:24:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu5/eqaIpVwwwa50DqmMKrB39NKhlZwdLHtsYGthsNbvbf6Td7aNviqn3EUtwWhqMcPArYWUXX5P9Nsr3evBk=
X-Received: by 2002:a17:90b:534b:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-2f452dfccdcmr34514409a91.4.1735219495183; Thu, 26 Dec 2024
 05:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204114229.21452-1-wander@redhat.com>
In-Reply-To: <20241204114229.21452-1-wander@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Thu, 26 Dec 2024 10:24:43 -0300
Message-ID: <CAAq0SUmVn57F5hc=iJkS1-8WPrguOcEYrirZ7hFgiFxhcTCowQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net 0/4] igb: fix igb_msix_other() handling for PREEMPT_RT
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jeff Garzik <jgarzik@redhat.com>, 
	Auke Kok <auke-jan.h.kok@intel.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gvs366RK0mxIfc5CasU5HwrC6r2-2_EiveiqMY3NsOU_1735219495
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 8:43=E2=80=AFAM Wander Lairson Costa <wander@redhat.=
com> wrote:
>
> This is the second attempt at fixing the behavior of igb_msix_other()
> for PREEMPT_RT. The previous attempt [1] was reverted [2] following
> concerns raised by Sebastian [3].
>
> The initial approach proposed converting vfs_lock to a raw_spinlock,
> a minor change intended to make it safe. However, it became evident
> that igb_rcv_msg_from_vf() invokes kcalloc with GFP_ATOMIC,
> which is unsafe in interrupt context on PREEMPT_RT systems.
>
> To address this, the solution involves splitting igb_msg_task()
> into two parts:
>
>     * One part invoked from the IRQ context.
>     * Another part called from the threaded interrupt handler.
>
> To accommodate this, vfs_lock has been restructured into a double
> lock: a spinlock_t and a raw_spinlock_t. In the revised design:
>
>     * igb_disable_sriov() locks both spinlocks.
>     * Each part of igb_msg_task() locks the appropriate spinlock for
>     its execution context.
>
> It is worth noting that the double lock mechanism is only active under
> PREEMPT_RT. For non-PREEMPT_RT builds, the additional raw_spinlock_t
> field is ommited.
>
> If the extra raw_spinlock_t field can be tolerated under
> !PREEMPT_RT (even though it remains unused), we can eliminate the
> need for #ifdefs and simplify the code structure.
>
> I will be on vacation from December 7th to Christmas and will address
> review comments upon my return.
>
> If possible, I kindly request the Intel team to perform smoke tests
> on both stock and realtime kernels to catch any potential issues with
> this patch series.
>
> Cheers,
> Wander
>
> [1] https://lore.kernel.org/all/20240920185918.616302-2-wander@redhat.com=
/
> [2] https://lore.kernel.org/all/20241104124050.22290-1-wander@redhat.com/
> [3] https://lore.kernel.org/all/20241104110708.gFyxRFlC@linutronix.de/
>
>
> Wander Lairson Costa (4):
>   igb: narrow scope of vfs_lock in SR-IOV cleanup
>   igb: introduce raw vfs_lock to igb_adapter
>   igb: split igb_msg_task()
>   igb: fix igb_msix_other() handling for PREEMPT_RT
>
>  drivers/net/ethernet/intel/igb/igb.h      |   4 +
>  drivers/net/ethernet/intel/igb/igb_main.c | 160 +++++++++++++++++++---
>  2 files changed, 148 insertions(+), 16 deletions(-)
>
> --
> 2.47.0
>

I had requested Red Hat Network QA to run regression tests on this,
and they recently reported that no issues were found.

