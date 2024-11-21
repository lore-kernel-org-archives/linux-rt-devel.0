Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C81AB51B
	for <linux-rt-devel@lists.linux.dev>; Thu, 21 Nov 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207824; cv=none; b=CmsZTegM9WNeQber6ZV4vkqMRvFfrVrcNDHwhcUzcBZNYJy8JQMJyiYBdlvgvxnkBV4aODaaGHJAzgbWfugn28d78HALJSRoXZhAITxJalgTOTCwby/IWNGHyzgM2c/RFL6VcNDPnyW5r9V31ZqK64cKPeP/dVNXcbQDTkqq3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207824; c=relaxed/simple;
	bh=1wgsHwaA0ppCKt9C0JManJN0XmnECUlYYPcU/vVra5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYPMuoWMnLCHoaWuJm4o25L4nxOSzrsMYpBxQ33r2N+gD8NA7ZGWo/ZJkq3lfKk2nK5P9YZmWq17FufKxaIHzM+s+SurUswfhVgBm3JJQBR5A40/vmOwP5LE+qYlYqQ3zwcYs0A7c/PnDNsUacMgsnM7ltsLlx8dnYsyG8lJVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSCkjkLn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSCkjkLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732207821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wgsHwaA0ppCKt9C0JManJN0XmnECUlYYPcU/vVra5s=;
	b=NSCkjkLnOQw9+5pSsG1iJHS29snvGG86NmCfgdxnvQ+hji4jpqCI/evJAshB23MLjGzICZ
	XJi/b9WSgBn2uEauSlOAgMxWuqulPtIU/DUUbjcFdgJoEotOiN7Dw2pwdqSohRoNrAcpsL
	FfGcQcaupmFZ0rkRc4Z1hB7I/RbYAzE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-CmdMHRbvMgmIneHnkTDXhw-1; Thu, 21 Nov 2024 11:50:19 -0500
X-MC-Unique: CmdMHRbvMgmIneHnkTDXhw-1
X-Mimecast-MFC-AGG-ID: CmdMHRbvMgmIneHnkTDXhw
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-20e5df3e834so10429535ad.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 21 Nov 2024 08:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732207818; x=1732812618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wgsHwaA0ppCKt9C0JManJN0XmnECUlYYPcU/vVra5s=;
        b=eDxpu7hU2M1SIAOjbFgeAN2jgYLxqed5OsHESwQEC876LydYVIB1gV/TfNVQVKar79
         0jp1gta+kPZdllf40CwjuyYh417xNWoPf9p3P0XuCU6K3ZalHwT1Asg4+2t4d1w3gOF/
         uOFR4LmoEEf58cbQPFoHU5EikbvA+uXWUutbDlUxhXvJiOAalXGxMwd6kNYxUAuKRi1S
         YXDPUb5lq8bIetsHZGCM5PlkZqor87dn4VHfDEw2XWg/QZtQeFiZdoNbCAjNf1hp9iPf
         FYkvLDPKJGiVWTE7/UOy4W2PH4k/os1eqDM1o6uGSB+Tc2XqS65cuYVOrOgbdmD+zcF+
         Ssvw==
X-Forwarded-Encrypted: i=1; AJvYcCUsvlr+/feuRO9nBblLfnGWgpIrpS4TO3r8m5G/6Sp3mN97lB67G+n+PsIkn8cFkiwNjy4OXkgGuKDD2A1K9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyFyelWSQS9g3dlQMyVMpN8FEi4FngO7i7Pn/gyqfQ6s/WGW9z
	JM0Y59R4mpyY2CdSNMx7722fmHVz3kUBsJDlIGwIC5tX1nnyCoynN6n4E3ujhyr7z67MATzvMkv
	2gGcYqHLAHgIENxERmsxfhlYjpmpCglvxrAWQonrVAcJLV1q6inqamG85iTfpEBT2yW1+yRDC9h
	E+owdwgeK8vjHmZ+Olcs1U7G8Zl4KQd9BwL/qeRPY=
X-Gm-Gg: ASbGncuoQs9wobn1leXfACbHKlGHrPMY36rfXC/P3H1Nddes8h20A38f3s7W9tHRrmP
	iroZ1sVdfU6yskc4blKebLi+gBDMFtpcF
X-Received: by 2002:a17:902:ced2:b0:211:f52d:4dfb with SMTP id d9443c01a7336-2126c1660aemr96184525ad.34.1732207817973;
        Thu, 21 Nov 2024 08:50:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYwUegOvnUGuFukyLEfp4g21DL42Vh3B29dqLz+MjQehoS8+iFeVjSAEr24CHu4SkIJ/uk9NSquFZC4b2ShW4=
X-Received: by 2002:a17:902:ced2:b0:211:f52d:4dfb with SMTP id
 d9443c01a7336-2126c1660aemr96184165ad.34.1732207817661; Thu, 21 Nov 2024
 08:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241120102325.3538-1-acarmina@redhat.com> <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home> <20241120164043.T1JuBALe@linutronix.de>
In-Reply-To: <20241120164043.T1JuBALe@linutronix.de>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Thu, 21 Nov 2024 17:50:06 +0100
Message-ID: <CAGegRW4B5PO0HgY1TvsV_R0hPSa5vHk7f=fy0skMpcy+BT399Q@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: 5mq4rRl748IObgqfSwdQutff7MBIBlQ9y4Y3eviUFmc_1732207818
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sebastian,

On Wed, Nov 20, 2024 at 5:40=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-20 10:26:02 [-0500], Steven Rostedt wrote:
> > The "%pK" dereferences a pointer and there's some SELinux hooks attache=
d to
> > that code. The problem is that the SELinux hooks take spinlocks. This w=
ould
> > not have been an issue if it wasn't for that "%pK" in the format.
>
> That is missing check and I think Thomas Weissschuh wanted to add it. So
> we don't call into selinux.

Your comment confuses me a bit, as I'm unsure what Thomas is actually
working on.
Am I correct in assuming he's addressing a fix in lib/vsprintf.c to ensure
that sleeping functions aren't called, allowing these functions to work in
any context?
However, his mention of "This fix for kmemleak is still needed as the
pointers in the kmemleak report are useful" adds to my confusion.
Meanwhile, Steven suggests reworking SELinux to resolve the issue.
Could you clarify what you mean by "So we don't call into selinux"?

>
> Sebastian
>

Thanks
--=20
---
172

