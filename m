Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B64B67F
	for <linux-rt-devel@lists.linux.dev>; Fri, 22 Nov 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732272501; cv=none; b=X+zwzq8/1quJpoSHeDTwm9rkhvhMpMxKIA5HMVh3yOh6jK7IUcdm3ZofFcuCqvq12Q8v47XmbGGjfEeRSCyQ0/iXEpbRPRO2PmzhksfD/D/XXkzhtc0YxNTAcHME9dqGcZSj0x/ZZS6co/N91D1z48xaYCYvvmUmqAJz5wAfhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732272501; c=relaxed/simple;
	bh=pJOdGDayJfCz/L+Uekx4UJ9FD/BOO1R8ukk28Rp+3OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6kmk9FgzBzfEcu/IwkP/O+VWksgjhdE31bUTLYN757k5cEVq/0tAlOcbQ/8SCUDDozghxQFB/B5KpXgMFdHnxuxAeeDIIZ/qnck+YvxfyOe0ApWvayo9jIDG8ky2cW7jvTj5Jrk9fr7tiDpSQyiqQ+vI4Kq3pioCj6QgyuwL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8ah1+jr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8ah1+jr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732272498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJOdGDayJfCz/L+Uekx4UJ9FD/BOO1R8ukk28Rp+3OA=;
	b=W8ah1+jrkDAnnry3q6sICNcsk/pxuFe0eI6S/1mhhBORBa6fkaX3ztORZlVx7kXGqxreje
	R3tmgTtZeiFpgFHeJsNZIIRlLYCMtMvbLHxTMtTJbg/ej1+EAjxqSAzx2Vu4HhhjWZ2+Wx
	gjrHzzv99dzkorvrRPJjE+Iepw8EnnM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-N9pbszT2MqmFvpWwnGWDBQ-1; Fri, 22 Nov 2024 05:48:17 -0500
X-MC-Unique: N9pbszT2MqmFvpWwnGWDBQ-1
X-Mimecast-MFC-AGG-ID: N9pbszT2MqmFvpWwnGWDBQ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ea21082c99so2091794a91.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 22 Nov 2024 02:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732272496; x=1732877296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJOdGDayJfCz/L+Uekx4UJ9FD/BOO1R8ukk28Rp+3OA=;
        b=Q3tTotBR0TUDttjC+w02QqYbRnbAdQ9fJF1U1Xpx2/e3IGEbjdY0vRMJjF27bXeCwk
         647c6MVm0HH1wBfkelmGAvzsdr+FyNJFhvL60z0PCB+cSZxs84aKgR505kuFX+NOYSSQ
         bV7pkGpzbvtjYnsDAd3O1vhXYLTHrKR/H8FO9u98RDkycmZHGvR1CzylF/HWqmBGwm/K
         i8DClqQSxMNypg2ilj1ishGlBlxekUQZbnxXfVOKFBTkY7QG9584uxfIJuH7aQp3fQU5
         Cj/bOGkJB/f+42mraVuLQ58p0kV6p4ZQgrLo2IlIgRjCNN5+ipwZpiI2Qlxp7FtBGqn4
         vRnA==
X-Forwarded-Encrypted: i=1; AJvYcCWdWB+4U/D6FILmYM+lM3ARLGG/mD2MQYewyDxXjebXOhC7ANqfIswcCEOwSRsnDePqOoc+2NBukgVYRmsapw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5G8PVaEJuTZy/OAzb2c3BOY6RdZrk2dUZ+FzrJArGG1czio2V
	1htf1do2/q0PIyUNwNDY0AhqMedcy5mNrQ1zX8bBID4Yw/rZhhnCQ0TasY/9sLXPjx6e8QWh3jf
	HZ31N1NnFJval70PDKZB3HLVyRZXo9ojj8uZ/rkn/2go0trzF9GcdZblybvQhfaigwbLjKxLHoG
	wjxGqRNlPTAAMYusqKBQop+yS3yE3zCCiRJCUUlSM=
X-Gm-Gg: ASbGncuI2xoulXaBCfWADlI/HoCYGs2g3Wg0AduWcFqJDV4hN4C0tSb50r6JkFycNZD
	4eBkLtjpxKyCDOpzI0DL+k088p/FrbVQv
X-Received: by 2002:a17:90b:2f4c:b0:2ea:5054:6c44 with SMTP id 98e67ed59e1d1-2eb0e8812femr2351579a91.31.1732272496465;
        Fri, 22 Nov 2024 02:48:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS9cApUHjXWWrIgw90VrNasPhY4FVjy3QXk4BeGdd2uda7CPeqokJcfMe9aNQ85SKWS1DVh6C9DieY+ywbWgE=
X-Received: by 2002:a17:90b:2f4c:b0:2ea:5054:6c44 with SMTP id
 98e67ed59e1d1-2eb0e8812femr2351551a91.31.1732272496095; Fri, 22 Nov 2024
 02:48:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241120102325.3538-1-acarmina@redhat.com> <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home> <20241120164043.T1JuBALe@linutronix.de>
 <CAGegRW4B5PO0HgY1TvsV_R0hPSa5vHk7f=fy0skMpcy+BT399Q@mail.gmail.com> <20241121170356.eC7f3-1v@linutronix.de>
In-Reply-To: <20241121170356.eC7f3-1v@linutronix.de>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Fri, 22 Nov 2024 11:48:04 +0100
Message-ID: <CAGegRW41HOdG+vEA6vwmC3WWJkRgMksasvoRWdwRzAE7mFbHEA@mail.gmail.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>, Eric Chanudet <echanude@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U3m91HXH9L_IVKQiVj-5nsboq6iMOt18KbheH5BPF_M_1732272496
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Thu, Nov 21, 2024 at 6:04=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-21 17:50:06 [+0100], Alessandro Carminati wrote:
> > Hello Sebastian,
> Hi Alessandro,
>
> > On Wed, Nov 20, 2024 at 5:40=E2=80=AFPM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2024-11-20 10:26:02 [-0500], Steven Rostedt wrote:
> > > > The "%pK" dereferences a pointer and there's some SELinux hooks att=
ached to
> > > > that code. The problem is that the SELinux hooks take spinlocks. Th=
is would
> > > > not have been an issue if it wasn't for that "%pK" in the format.
> > >
> > > That is missing check and I think Thomas Weissschuh wanted to add it.=
 So
> > > we don't call into selinux.
> >
> > Your comment confuses me a bit, as I'm unsure what Thomas is actually
> > working on.
> > Am I correct in assuming he's addressing a fix in lib/vsprintf.c to ens=
ure
> > that sleeping functions aren't called, allowing these functions to work=
 in
> > any context?
>
> restricted_pointer() has a check for in_hardirq() among others. This
> needs an additional PREEMPT_RT check.
> I would be actual in favour to get rid of case 1 for kptr_restrict and
> have either 0 or 2.
>
> > However, his mention of "This fix for kmemleak is still needed as the
> > pointers in the kmemleak report are useful" adds to my confusion.
> > Meanwhile, Steven suggests reworking SELinux to resolve the issue.
> > Could you clarify what you mean by "So we don't call into selinux"?
>
> This getting out of hand. By adding the PREEMPT_RT check to
> restricted_pointer() we don't call in selinux so the problem is gone.

I am really glad that now we have a clear solution, however practically
speaking is Thomas working on such a patch or is he working on something
related that does not fully solve the problem?

Even if he is working on a partial solution, I am happy to coordinate
off-list working on his own private branch
(or else I would just give up and review the Thomas' patchset when it is
out...)

> kmemleak is not the only problem. printk(), as another of vspritf pointer
> code user, can be called from any place and would also trigger a
> warning here.
> As far as "kmemleak need to be usefull" goes: With kptr_restrict =3D=3D 0
> then with or without pointer hashing they will be useful. If we need to
> go via selinux then it ends as a hint.
>
> Sebastian
>


--=20
---
172

