Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8131E833D
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Sep 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919814; cv=none; b=QZln9c7nmONB5k2szG3cI6qiKXqaVoPREiwgdxpxrdOKuHXUpNJ5S0L3P6lF48BovccpZvSFzs7wK0fJUtkQNdjeX+4i74VouwpBWMmxEVy+Ox7WEPYRSCSpKg/30VyZHM/nHyI1mZJhXy0WQ+Fw7uvJlEqAdd1Ha2nLjMj1J/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919814; c=relaxed/simple;
	bh=ZJ6DzOKUfHZ5IofQc/gAACB4SYGhZXU7IbTqulvb4aw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=COa+wAtdiVTVmef6pXDKTjmhNGsJYhm09KJFy+qeAtrZqEJazPMrNrCARAJeqP6nICVA+V8u0F/QBX3pT00WaJ97cJKmCOmcuCjWKkxWZiiaGoC/BmIh9imdV0FvDCkoIYKgSeGx94Fv3/H+vgYNNZqD5fJ8jMXWCfLxualDFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIJ+CtFx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIJ+CtFx"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b490287648so2288811cf.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Sep 2025 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756919812; x=1757524612; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWlwFBgNWMjfUe6WnDjCIuuCR2uq0Rac7cIQSEflAow=;
        b=mIJ+CtFxlmjiw6K1EG+sqO7BXBfULOh2DZG1bcsCsgSgj6bLdp5p8qRp7nOOCx6wK3
         OPHGOkNxuz5L+DE9/VFusySm4SzGeSLMmiZ6k4qJJvnuVBfotLAGegK+MOwWFZpcbn4r
         4i/LBXpz0UQ1CuXlCs5RX4teDDuVMW9bgptAr7kS2MmrERCFDRkG2wu68Qw6aFZoZzVp
         o6xPqFXfJ12645dGL/4gxxiqjsMBOz87xJ0Ksi33tq9XScVcaQE0ACwaOeKqFby7/DwX
         31bX1YWjwcniYrTu64YB7TNGian6HSwJQ0IpLnXygVZtII1yG1M4FQFeA+wMff57kXur
         /21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919812; x=1757524612;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AWlwFBgNWMjfUe6WnDjCIuuCR2uq0Rac7cIQSEflAow=;
        b=Mgdc3yTMQwgRvKuK+slNg4+qH5keaNuEngVo5tCeQ0z66D5YyylHm4b8RSCVwak6pk
         f0fVXgRL+TQUceWqRSsPM9eFAojvkp8cjwVJzEriLOA2SGohiX2Ng+urmO6jRIDLaV7T
         phvjeOQRzBqhMSsN22h6u0XX0rR8WuRiSm1uy56slzpMmQwO6GCSR6499cgbSlVmdsp/
         jrdtfoNefWD0tfzmbg8y6iB2ZPuAvh0pahnRlMtPSb3UQBGdHvxuqqMKFfGOzbEaO0o/
         7bkQCB8TVkSkdO7qQ1YB3eeXtznVGMrRx2duxwzSjt0L7dtprUkAKdY3o98i4tauPxLB
         4BEw==
X-Forwarded-Encrypted: i=1; AJvYcCXrEbt3fA7q5/cUZFpxPYpxlfoJcusJtZaCwVPotEoZwD6fpuGLCRgUWKTBodIhDNRTPjsZWv2gkIO7lgQ2Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQk/sNmfA4flcRmXwy9EtzClxi12ulbydaC4gW0YzW4fOO/mtY
	qnNWMm+ogjAbHF9LOTDtBnieZyhGtDa5wyTeQNnTHunfIW/k7KLVcQJd
X-Gm-Gg: ASbGncukDObkxi8XypD9hJXcnfkntyc+9jDmpkT0uErzXCDpaWH3onn+Pyclh1WY0+z
	pcw7oRCXMufFoQqKLzlIv5U1t2Ql03jVQ++zmjMDGbJAuuw5WLdn08CKHxvx2DU7YJda6YmkkWz
	haI0XxOY3DRL7pS31xanXf8wMG1JPjKVpZ87ADygUMVpxz2oYH8JHHN6J9JP8oDdJarpieN6KDH
	t/yUDlgBTQ0uR9MyCfzSIENgj1jL7FLmWYViPrRHEFMiseEqTTfJSQnxeFV2XZB4M6oQ6Z+HrxZ
	7PdLsHEva8TABHHRUQtJT9Odd5q0B34u17kftrfp6PkoAiWWOLLzTG7y1LQFHE+3HdX+UkfxrgU
	6Tbb4xHtEWnf7U42cPfmMj1PzRRMm05UfsdXiMKJ8zCUF2QC1vqN0nweRFcw/4YaUNNLhjb6QEY
	GZKA==
X-Google-Smtp-Source: AGHT+IHQeEGvElRE3Z4ZiEhlcG0xfeqMhZUV+xEqkDaUsSNp4u1kO2SKqlQm+fAc1bfWx9X2QI3Egw==
X-Received: by 2002:ac8:5fcb:0:b0:4b4:9773:586c with SMTP id d75a77b69052e-4b49782a0ccmr25315751cf.66.1756919811605;
        Wed, 03 Sep 2025 10:16:51 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b5d57c6cc0sm1491041cf.53.2025.09.03.10.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 10:16:51 -0700 (PDT)
Date: Wed, 03 Sep 2025 13:16:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org
Message-ID: <willemdebruijn.kernel.3093d8d8e5831@gmail.com>
In-Reply-To: <v4bz7lyzs6f6mlfhvgy3p34sihu6sojwntbev3hz2sz425j76i@wanin427lov6>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-4-51a03d6411be@debian.org>
 <willemdebruijn.kernel.9ee65133b4b7@gmail.com>
 <v4bz7lyzs6f6mlfhvgy3p34sihu6sojwntbev3hz2sz425j76i@wanin427lov6>
Subject: Re: [PATCH 4/7] netpoll: Export zap_completion_queue
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> On Tue, Sep 02, 2025 at 06:50:25PM -0400, Willem de Bruijn wrote:
> > Breno Leitao wrote:
> > >  include/linux/netpoll.h | 1 +
> > >  net/core/netpoll.c      | 5 ++---
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> ....
> > > -static void zap_completion_queue(void)
> > > +void zap_completion_queue(void)
> > >  {
> > >  	unsigned long flags;
> > >  	struct softnet_data *sd = &get_cpu_var(softnet_data);
> > > @@ -267,6 +265,7 @@ static void zap_completion_queue(void)
> > >  
> > >  	put_cpu_var(softnet_data);
> > >  }
> > > +EXPORT_SYMBOL_GPL(zap_completion_queue);
> > 
> > consider EXPORT_SYMBOL_NS_GPL(zap_completion_queue, "NETDEV_INTERNAL");
> 
> Thanks for the suggestion. First time I've heard about the export by
> Namespace. I suppose then I need to have
> `MODULE_IMPORT_NS("NETDEV_INTERNAL");` called at the caller side, right?

That's right.

The feature is fairly new. I don't think we have clear guidelines what
is and what isn't in scope yet.

In this case, it seems clear to me that this API is not intended for
broad use, so falls well within the area. More context in
Documentation/networking/netdevices.rst

