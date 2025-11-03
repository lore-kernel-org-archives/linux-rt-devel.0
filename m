Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF30314A77
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Nov 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183615; cv=none; b=n30hnnmlmjSPogqmL4kfIi8OYGLDqDK+csn+iTqoQ3GidW0zHFmIC14B4F4qq0SedjIViyUKrmMa490GXSGKj3m75jbm/Uz8G1xRyqvWdwgV+iaPe5RC/KYs8KUaP8eX0ebnHhrGgJ1QqMsxsujr2iOr5tMSC577f/bQZR6tTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183615; c=relaxed/simple;
	bh=HtYPErm+lcPCQ8/H+Y+ENMRB8yN0YIO5X53KhPaEGXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMnlQyDvRs+PVpPHYuz3V8yhGJ/AypLK7qR9XaLc54FIKHjiZX/BobRqDFSHhNvqc0KsSqGgm6YcMSCP6haNkqie7FHwvqdImjbaq05n6AbR0pE6lRgdZzfnnzmwmapIqJdYaTHmjW/hBhiRrjSMmmBcgN60nEn8LpOvBCvMthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUCCJIF4; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUCCJIF4"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4eb9fa69fb8so62142521cf.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 03 Nov 2025 07:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762183612; x=1762788412; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZSWiwQJqc6XKle7yFUK9dQujqeGGNiGFVFQdXE3oOQ=;
        b=zUCCJIF4vM2JenO+sA9y+KvbtZ94eiSvady9wLS50hWdRrVLIwSOROYUbq9mPxerrw
         ETdJlgw923SFuByou7JqUyNqQL//YeOgMKiZICsLXvZRKD8QzZoN6NecGRz5HPQDc/IB
         SVQUHnDcH714dBogvUIZogkja9vxUF8s+WS4jDVxe8GhwXVRBExhdlzkJyyDqH3yhCPL
         K+g0eQr8NSKAzhN8mCdMgP4+bSz8aKl8mepFry+WD1OCGEaSGri6cgP0JcWL8GM8Vchh
         V7qwwEwFOpCM56JoPhU2PrdrxlGvd1oTmj+nxkzRTJJeY3J9/xD2tobKhkV7v0x8ghIu
         cpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183612; x=1762788412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZSWiwQJqc6XKle7yFUK9dQujqeGGNiGFVFQdXE3oOQ=;
        b=k2iZ8naexPQ1MddCoglIAtKoE3rarICPpaTMIacW0eGpcR4sKicMQS5sw5y85vuswa
         mNHEfmhjIp0XB1+hkDEe0y4dMgfRk742lles4bDcexHhXAi0P+BcgTjk5y+ctZ7jXT5x
         9rmh69xbIJwjYcLGY1qklaE0EiOqVErWmTS0lHEC3JA7akXamposCG9TMIQyphq00fqO
         Eefb1dzULJ5ZhsPoofklOIzLqB+nTAALC942IM/SDmqiEMwumZD+uB8l8YSYOTIOutga
         5JcIVmDflNJnIQ52/T6OpoW1hy+mShsuDjf+dM5OAPSLS6K/OR0NJlkhv910TPgrS4Jo
         Zkmw==
X-Forwarded-Encrypted: i=1; AJvYcCWiprEh+DTOA+1UJFaIN6QDXhCpbWv458tDnAQ3+s/4WEYQFn70Ha/keFcyeXXhtDisn2JDwLkFiAWaccPB9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3Ktz0rVTt/Y8FPUrTU4ZO+Tt1Zpk6yGc6LEc7sTUH2iKnzoKA
	fuY2vm/adiM7FkhPtJHeLW2W3l+96cZ3tkVOx8xdaR1u9HEQMqO/rCGCt6+EwxzQfU9TUyAXE/S
	TZ7MbvmZClmrJgB6kNekxkKqRP4AlpdYDsJsLbDjZ
X-Gm-Gg: ASbGncs1Yn0FTWtydyn8iE5PhjR8rBtJkooHT3xzZtiFdjCPWwB77eXsvLJIXaYMy4W
	Eik+MlforXXzEFdD0FBqPSfr6dUx+kQu2/V5T/voORTv0MHiueEX68LWx8jdyPIyOoKmWHBXhkO
	k5eLQC4VsWTEDrGPzxj4og8547UNi0dtTSPX7HsgkW6FrgKVe99VHHMW6S+XQvR1q1W54Odj0Lx
	K1pC/roHykQZli3v8TStc/wgdAu4ZyDccrlAkf61XBzOrH/9a44FtzneE50qb5UV1fpRg==
X-Google-Smtp-Source: AGHT+IF+mGJu8f1sIqdbKIgmUXDm3aO7KzyDpfzDBD3k3+tS1nf7R8zcW/+SyzIacTciXf8ui1YRp56XzAYhwO3skb0=
X-Received: by 2002:a05:622a:2591:b0:4ec:f4be:6b12 with SMTP id
 d75a77b69052e-4ed31073e8cmr165852591cf.72.1762183612241; Mon, 03 Nov 2025
 07:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251009094338.j1jyKfjR@linutronix.de> <66664116-edb8-48dc-ad72-d5223696dd19@nvidia.com>
 <CANn89iKvgROcpdCJu726x=jCYNnXLwW=1RN5XR0Q_kbON15zng@mail.gmail.com> <20251103135918.mieB1dYO@linutronix.de>
In-Reply-To: <20251103135918.mieB1dYO@linutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Nov 2025 07:26:40 -0800
X-Gm-Features: AWmQ_blK-HQjVUx7Fz1ixHyCR3tPrcYSWynAmxPxVZjLtzwD4YwWomDo3bMRYAI
Message-ID: <CANn89iJaf3qwTL82qJyDx1_Eq0RAQuprdy7CyiRd8YWoXD=Vzg@mail.gmail.com>
Subject: Re: [PATCH net] net: gro_cells: Use nested-BH locking for gro_cell
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Gal Pressman <gal@nvidia.com>, netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 5:59=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-11-03 04:36:45 [-0800], Eric Dumazet wrote:
> > Adding LOCKDEP annotations would be needed (like what we do in
> > netdev_lockdep_set_classes()
>
> You mean something like
>
> diff --git a/include/net/gro_cells.h b/include/net/gro_cells.h
> index 596688b67a2a8..1df6448701879 100644
> --- a/include/net/gro_cells.h
> +++ b/include/net/gro_cells.h
> @@ -10,6 +10,7 @@ struct gro_cell;
>
>  struct gro_cells {
>         struct gro_cell __percpu        *cells;
> +       struct lock_class_key           cells_bh_class;
>  };
>
>  int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb);
> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> index fd57b845de333..1c98d32657e85 100644
> --- a/net/core/gro_cells.c
> +++ b/net/core/gro_cells.c
> @@ -88,6 +88,7 @@ int gro_cells_init(struct gro_cells *gcells, struct net=
_device *dev)
>
>                 __skb_queue_head_init(&cell->napi_skbs);
>                 local_lock_init(&cell->bh_lock);
> +               lockdep_set_class(&cell->bh_lock, &gcells->cells_bh_class=
);
>
>                 set_bit(NAPI_STATE_NO_BUSY_POLL, &cell->napi.state);
>
>
> > Or I would try something like :
>
> I'm fine with both. I can provide a patch body for either of the two.
>

LOCKDEP annotations should be fine, thank you !

> Sebastian
