Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A411E47D1
	for <linux-rt-devel@lists.linux.dev>; Fri,  8 Nov 2024 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066279; cv=none; b=J8FXFaAsP8hTIZVDslXfO1mjI2rL5KwxYNtWFyNwj/G/U51DKgykk6Gw+ziu5SKirA7eV2toptsRRyu/N7tWHxmqKHAbZeo+L5qWIL40qqSRyaYyFkHpA51ZYTEra1IefLor87q13oUIarP0LAgT1HV7qNvwvQ344WzcShXBMAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066279; c=relaxed/simple;
	bh=+lU6GBkmCPFmCNwxSrgrgIkwiITyF6fl4wchytIL1fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9Qp1ug7dMwxxDKoVrHOfMO/7G3OMwzDVzolguKcqZFUHwVIx45DCgvBo1gLhn7Xw4gv51jvnuB6q3HN6rU9d0RgPit0v96XlNa5jwlMROD865tXkN0MQFWrWXUjvB47eA36iAZIZA0kK0BGqkQ3X3nng5y+UkfauKiSdQrT2lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8qXvYVl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8qXvYVl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731066276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lU6GBkmCPFmCNwxSrgrgIkwiITyF6fl4wchytIL1fU=;
	b=B8qXvYVleQJVM+q6bbRWnxRgYTw8G8f8JnwWpQmEJ1gRj5idx2scrcp8e7cJCRRVEVj1eL
	z2jghUgIsrN8ZggfYMq8liLfjWSFOtChFuElTCrOaLjSUbuPOCfbbFHDhD84lD6zrMD1Gx
	WssUVsDZuJnSeSFR4lnaRZ+de34kmR0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-ehuiwS8JPzaXnIx-bIqOog-1; Fri, 08 Nov 2024 06:44:32 -0500
X-MC-Unique: ehuiwS8JPzaXnIx-bIqOog-1
X-Mimecast-MFC-AGG-ID: ehuiwS8JPzaXnIx-bIqOog
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e3b9fc918fso2191606a91.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 08 Nov 2024 03:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731066272; x=1731671072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lU6GBkmCPFmCNwxSrgrgIkwiITyF6fl4wchytIL1fU=;
        b=CRCyBIasg2AX36Pgg/RQh5bsk/AKW62WJJW7wureQxZG36KNPlJ4EOL00qszW1OaYh
         KPRAEA4mswNdhFKeFjhiGbVTgDdc9jZ0dCQuHyMzr0m4nEMLCPdRu1+x0Lo7P4WX/SwV
         KJDS6mrtdGOZg/oCxo2sx4shC0gBv5ZgWPV9qkZDoWcClHBNS1sFVntLviCciyw64qWE
         lLOTtPElsSGfZmk3uSx6GSDDzOZ0vXTfq/1QF+Jxe0QUjefGWSpmke9qsJvcQqZqGJmi
         Vc+yGhaSCC186+KqmeW+h4PTlxT9bYfqK4Yv6b4VEgv4uoPwQl20i/Kewfce82w+e0zi
         MvMg==
X-Forwarded-Encrypted: i=1; AJvYcCWe3/Ewfb8Dy/jPHuzBxexzIXV/bCLc1jDAixB03ycLE2RA4F5dyIg7A5TaXcpANwNzUrucfPJqhfcqLk5IvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTeThLd3J8Idsjmrt6oiI1MslLR1YlqZXGs4r1MjKSRrlsHEb5
	msh5/aHU/0Vv8WvK3mLhWE+gK2AqyhqcfUelKphEXTrqONbazqvu4VVRzI8aVfiChGUOITfsDcK
	g+P1eUEFWh8VTsYQQ7Z/VNY8xPbSWZ8ZAP4m98nRHhP6VfYFMgWqZGHepW1jggomzVEZy1eR1K2
	8adzqHZ1MPkqYt120VAJkWRa8O7CjG2d/cZ4vP9co=
X-Received: by 2002:a17:90b:1f8f:b0:2e2:b02a:1229 with SMTP id 98e67ed59e1d1-2e9b178fe37mr2922940a91.35.1731066271836;
        Fri, 08 Nov 2024 03:44:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxIMFhFEJaXhMKyQro+WyOM48KyqyrmXQzVcAxRO+eiRvB7RVIYRHANvMBBHAupPuqRNnBIAp5H2+HfwwyoV0=
X-Received: by 2002:a17:90b:1f8f:b0:2e2:b02a:1229 with SMTP id
 98e67ed59e1d1-2e9b178fe37mr2922923a91.35.1731066271591; Fri, 08 Nov 2024
 03:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241106111427.7272-1-wander@redhat.com> <20241108072003.jJDpdq9u@linutronix.de>
In-Reply-To: <20241108072003.jJDpdq9u@linutronix.de>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 8 Nov 2024 08:44:20 -0300
Message-ID: <CAAq0SUnrtYadVZb=2G5PW0dBJxovzS2F2841-gCHqSp_5VgsPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Revert "igb: Disable threaded IRQ for igb_msix_other"
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>, tglx@linutronix.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gybVcV6weI89sl267zqfLINLD4S2nriWRDW_VBocB2w_1731066272
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 4:20=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-06 08:14:26 [-0300], Wander Lairson Costa wrote:
> > This reverts commit 338c4d3902feb5be49bfda530a72c7ab860e2c9f.
> >
> > Sebastian noticed the ISR indirectly acquires spin_locks, which are
> > sleeping locks under PREEMPT_RT, which leads to kernel splats.
> >
> > Fixes: 338c4d3902feb ("igb: Disable threaded IRQ for igb_msix_other")
> > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> This is the only patch.

Hrm, I had other unrelated .patch files in my directory,
git-send-email might have gotten confused because of that.

>
> Sebastian
>

