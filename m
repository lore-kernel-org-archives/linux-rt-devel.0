Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C641FDE3B
	for <linux-rt-devel@lists.linux.dev>; Fri, 14 Mar 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954357; cv=none; b=fT+OHhYSrX1gLnsqP+MKNxzALNF6yqAqgt3s+kyC75ob8k+OP/tYYve8V0ASuV7uf6QPc5U+qndYFDgf1sF8x0xXI+/2wyXLRcnu9VZsnhqRhSSS4WFJ6po6tsprktBcJ5thzBLgDbEbIoqa4Y4dOnUgE06mPug65PCbX9LgHhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954357; c=relaxed/simple;
	bh=oyXLZj54LtlQ4MGhnb2WIDH2KSeJ1AZFFTQTKY/k6Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaLOsKjuU+/KJHl7vsADyohqain5jJB+KdKf47s9NYl5Df4Pf+SJRW1hQURvo1bkmNDWCM9FQ56Ogil8iCTiEo7/bfQTSrAF0nuCFL6w5GwRv4WxXIkZR+TU7+OFSAziFBms3xaXGPh51Dpdlh2MFuy0mOaI+3cpyFhTR7zJWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlnr7qaM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlnr7qaM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741954355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TTDZeaw56VIBY+bEWJ8m5Ut0VG1D9nOF2jWYVpTaHVM=;
	b=hlnr7qaMGqmg+KBPCfTA40jQLXq054Gy8wMEAkSVtX6a2S4UOOPlcAA56HFUTXTKwnoPKT
	xIAkL1djsXNgVN9iRaGtuq4mWFf9EhjcoLZB7irmMDyQ0QjYjby6HpGoXUlzpYIPR1MkRN
	EN8ghkVT9gRGfGm2738meQ6qNJAiz5g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-xsOU36EoMImTeYP4oi1ltA-1; Fri, 14 Mar 2025 08:12:32 -0400
X-MC-Unique: xsOU36EoMImTeYP4oi1ltA-1
X-Mimecast-MFC-AGG-ID: xsOU36EoMImTeYP4oi1ltA_1741954351
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso3563345a91.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 14 Mar 2025 05:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741954351; x=1742559151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTDZeaw56VIBY+bEWJ8m5Ut0VG1D9nOF2jWYVpTaHVM=;
        b=lruYPggCp6wimJB3F3BuZpJUJI+oBJhGyEP38IqExi/ZRpNbyyArBVWZQMgpD334ty
         sq3so/ut4Bs4BOLmVAKrqjLt8dbl3pfhvxQuMdj+xvlZe6kfSjeUyEk8RBMynujV7L+a
         ijIUucVo9lLbh/BV35LV97EtFInAFnWt2Ijzqgks6Npdk9ulTNFPAFTCvxez5ImDWdkj
         KkdrBjy3BU2QUc72QhmjYf1zFb+d/22OoFdbliAtEU7OX40ce32kns/70hCYIhP+GPv7
         QXQh19MU72IqNjehT6MRplUcABqOgodw00+tel6ngXk3dPP12YQo85TAfadmqzOW5wtV
         wfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0IvZmh+t+pqzk+6qzxxRkWEgUhoRW1/qsiHRDCzazTbhqxePrPIjgAEYrnPQV0M961sj4G01of5htXRiTcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRRuZRPy/QivsnSkd/vOy1/sFhl86L+MXRIpwcbZAvPtH1Fifr
	e7zxD6DsPhakthJfIWoN7NR5qT9wCcugrQniY+POufTs+4TBzric8TeLQ2RDN3o0CIV11xoOzjb
	O73eIVaLhZTIOtr1V3MKX9rmogJrxUunbERlzPsIKvSB49YSId4NZSNpYfMruxq6TR0aDPV+CKf
	N25jTeR3Q/qBUXFRdKeRw1CfETH4baCs94/AoIpzU=
X-Gm-Gg: ASbGncuA+gEq4KZptjneOWrQoeSRKtj4749AJ9PmpH9oiM4lPeEFAk4TJRqia0fa/uJ
	jf3fSJrfoRwnRaURchzy7eYRAL4ZziMqsWPKroNWcZzJe9AcBEyCH+2IeY7RA+AOIzInvD5qy
X-Received: by 2002:a17:90b:1f8d:b0:2ee:d63f:d8f with SMTP id 98e67ed59e1d1-30151c7a361mr3127189a91.13.1741954351250;
        Fri, 14 Mar 2025 05:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSnl0DK330+iYxumrpeH9uLx3TdPoT2bdl13R1/PQEAjWq9XZqWeit0LjaMAZw3sh9KdYE58oYwshB2exonS4=
X-Received: by 2002:a17:90b:1f8d:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-30151c7a361mr3127166a91.13.1741954350985; Fri, 14 Mar 2025
 05:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250205094818.I-Jl44AK@linutronix.de> <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de> <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de> <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
 <20250212152925.M7otWPiV@linutronix.de> <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
 <20250219163554.Ov685_ZQ@linutronix.de> <kwmabr7bujzxkr425do5mtxwulpsnj3iaj7ek2knv4hfyoxev5@zhzqitfu4qo4>
 <20250220113857.ZGo_j1eC@linutronix.de>
In-Reply-To: <20250220113857.ZGo_j1eC@linutronix.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 14 Mar 2025 09:12:20 -0300
X-Gm-Features: AQ5f1JoYrKjuf-swh1L4bBwmMxYWoNIB57J4PFNL4X9qlWDh80egegT4FKA54Hc
Message-ID: <CAAq0SUkMXDaSvDRELYQn9+Pk-kBjx2BWc7ucme54XPXD97_kkg@mail.gmail.com>
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, rostedt@goodmis.org, clrkwllms@kernel.org, 
	jgarzik@redhat.com, yuma@redhat.com, linux-rt-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RI_X2WRESMnBmvnDCgSxflRlirexFKzzZsEQke_g2os_1741954351
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 8:39=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-02-20 08:35:17 [-0300], Wander Lairson Costa wrote:
> > > You confirmed that it works, right?
> > >
> >
> > Do you mean that earlier test removing IRQF_COND_ONESHOT? If so, yes.
>
> I mean just request_threaded_irq() as suggested in
>         https://lore.kernel.org/all/20250206115914.VfzGTwD8@linutronix.de=
/
>

I forgot to answer, sorry. The answer is yes.

> Sebastian
>

