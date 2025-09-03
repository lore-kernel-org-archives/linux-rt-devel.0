Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FC239562
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Sep 2025 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918324; cv=none; b=G9bV09Ol6MOLHLRMwx7ilEHGYlNMcXALnpbY+n3JgROjQKOvB5/X+gcrQRgtwgHTorSKlyI+OVbWegtLw7Ph+7FSsTNt4iQruah1XDME7GFHeHm8nUiqUVpaWALck5xoDYTEky8HG5jV0znuoTV0O9WbSva9PfV9XBZZApBe2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918324; c=relaxed/simple;
	bh=SC4vvCIh6HVYZODXSXSISU1/mNuZk8irrLwPdBkb1LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9V47A+3H7YqJBhdmEGWrfYrbx0WM0hJtmscx37KZtJn6S1+YthOWhJK0s6pfIPcw7K5hvmZkdRACAwaBMbqL6SpuWXUypFx14Mmm4fb4RzE0/LsB7SBtLKuPcy6Wqqd1UskcpI5dHV6bq/Y9WTEDI8Hu+xDpME6oPKyI8hLDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afec56519c8so16027166b.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Sep 2025 09:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918321; x=1757523121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS8yFqssheDT5JhDABA5pXfJxzkDyZX8nmQKjAuFt9o=;
        b=Dt6/lkf53q6bwLTbSkdZ1Fle46AV3baOMRlRfwfXNYlk5jt++zM+PcxikYtA3GRVDR
         AtW5lJtFWdt21iD12tw9zT2STtLvgJgTw/xDNdNw7gCZifQvBs+OpZVHvdNvE20nh12d
         IS3qdon9lNIoHkJsZb1Kb8uO3VRwZ1tMnOYMzUVVdNLbkby7t8x3EB+4Z6vlUTpSynSK
         goXcc72rEwUsbtzTREdW6ORiBkjwANRSzoFXOkbP973aKT5isyuaCryJSyS2/zs5XYhV
         5Io50bnvsl4BQgV95oBx0OWGqWRjFEcPjRs2i7OAvLEs32OQ0tea8KByD7LjTv849Mnm
         jWng==
X-Forwarded-Encrypted: i=1; AJvYcCVnPP3I30e/Qy7Lu8bLmAqAnknfXKROzBiWLUQ1Dh7NNi2cVaGDos6S9dStK2D2hvJmqlt/bR9kL6Nb51+m5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YznVuVBDmNE/1aOCaTad4fYawIcMoBI1J684sG9EWepemES8EJL
	mA2jN9hIa+qDp7NCvr/da4sLP7EUr1yFXTcyVFqCKT6/1SVpv6zd2vGg
X-Gm-Gg: ASbGnctfHgwheedj/dxmf3zElMcSazDRejwu10306qDR3xsde06lKhs9moGZ1LribuC
	iN1neZQT9ZQW/EXIABr6zuF3G3bUNa6v3kaa+E0jF8KqttL2IhXGThGlTpjSm8gqsN3r/j0aoDb
	Mtec79wwJjlygwrXc6G2hzVUvsSAzzjHcSunnsAX0fN53H9b2Meb9WZPTgUpdogcAX/CT/PNaN5
	GmwJUxQ0OW53n/IRSruJnhti+3vJxVy9AZDRTuJkTjlO3Jy+oQwP5K3WcGwEpjGHSd3kz/q/YcF
	+7n5ckB1Y9vu5uKUjGNTLwqzlwgSQBOwjMDhyF1j0rXvDsCXpPnzFyy5AqnHsGl8Xzzx/vsceMh
	n+dEpKZgTCwbCtCWbUnArOZM=
X-Google-Smtp-Source: AGHT+IGGflStVCuHzCFsc78Vh1Q6ajVQk9iXe7sBDgr5P+ldeTJ4+esXOhqB9adB4iccLVfZDfPKLQ==
X-Received: by 2002:a17:907:2684:b0:aff:13f5:1f0 with SMTP id a640c23a62f3a-b01d8a26e65mr1488688866b.7.1756918320662;
        Wed, 03 Sep 2025 09:52:00 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046df9a44dsm153072166b.70.2025.09.03.09.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:51:59 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:51:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, calvin@wbinvd.org
Subject: Re: [PATCH 4/7] netpoll: Export zap_completion_queue
Message-ID: <v4bz7lyzs6f6mlfhvgy3p34sihu6sojwntbev3hz2sz425j76i@wanin427lov6>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-4-51a03d6411be@debian.org>
 <willemdebruijn.kernel.9ee65133b4b7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.9ee65133b4b7@gmail.com>

On Tue, Sep 02, 2025 at 06:50:25PM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:
> >  include/linux/netpoll.h | 1 +
> >  net/core/netpoll.c      | 5 ++---
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
....
> > -static void zap_completion_queue(void)
> > +void zap_completion_queue(void)
> >  {
> >  	unsigned long flags;
> >  	struct softnet_data *sd = &get_cpu_var(softnet_data);
> > @@ -267,6 +265,7 @@ static void zap_completion_queue(void)
> >  
> >  	put_cpu_var(softnet_data);
> >  }
> > +EXPORT_SYMBOL_GPL(zap_completion_queue);
> 
> consider EXPORT_SYMBOL_NS_GPL(zap_completion_queue, "NETDEV_INTERNAL");

Thanks for the suggestion. First time I've heard about the export by
Namespace. I suppose then I need to have
`MODULE_IMPORT_NS("NETDEV_INTERNAL");` called at the caller side, right?

--breno
