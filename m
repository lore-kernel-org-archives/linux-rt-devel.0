Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397791D79BE
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601070; cv=none; b=mz1y0bIfbb6boC8a5pDqUGuSSaRAZIQppe5irizyjSI3Y9Fppgs1J3P0pUnlAUpUaE8htgHYkHyVcD6T8Kkmz8bdvRyKgqLm9ClV6ombtIqzJwPohgb1Csp1rahYCcXfLuT7dGdPLP2sFBQN7ZMU8Zz+4yvDfKo/bKG11O7jH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601070; c=relaxed/simple;
	bh=XfSVpD9Z7XphBM4ixb2rCWDLMorg8f3Q4PGNqpR6KAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HCueLXJW21Q7btRsUOpmk7RSrSqs2T8ZZ969Y8PE+ONN3pBv91qgcbupDvb7C1KtLI1Lthqyum97nYf5fA0hGX52yrMDXed3AVHQnj0FlJszdz5e81DAr1hnrWtYP7wXyh2BVeRvZPaniaO/xz7bwa5eEWSU2w6tUij+29jScZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5Dcln1k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5Dcln1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752601068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cdcx7QAfZlAuJUAK+fb/wqda3KOPzzyARCBWyre1UeA=;
	b=Z5Dcln1kc80p/JdAYtKNjopMo1nEcKksxJZc61h4isR9IjCNqsbDHmojCOEbJQsAbamNX8
	vOKYsAycaxJ4+qxkzK1Ir5RS0irNKvRrPcPuvb1VfkAq9z9dr6mbp6YRrSGCMzXZYA094W
	qcqStPwB61OlwR7nxubwf3Fsl3EiEGc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-YVLYnSUZNC68AQUe8tfCyQ-1; Tue, 15 Jul 2025 13:37:42 -0400
X-MC-Unique: YVLYnSUZNC68AQUe8tfCyQ-1
X-Mimecast-MFC-AGG-ID: YVLYnSUZNC68AQUe8tfCyQ_1752601061
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4560a30a793so14554975e9.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 10:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752601061; x=1753205861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cdcx7QAfZlAuJUAK+fb/wqda3KOPzzyARCBWyre1UeA=;
        b=d+3hsJztg4o2w0lIQaUtcrkv9ce0v1gTGJsx0KtKgmUeQs1DIk1HBtSosqf7g0Bibu
         9hjRRZuNGUjaLPFXsbGd4OjGQpKxynAUUQL5gOqIYgJt/JQvXT/L+dX566D9W5xIVGAm
         FbkcxWjsnDBtL4kfuJKvgV71rKAe/Xh5OXI1xkNS5WnWiAPt0Dk894OYQ2v+1mfvk5Lj
         MZ/38vpvszaMeDLqxVopp32s6piCltk5oduYtTU0BEj4+Xkb6i0RZe9UValULMMhsOKO
         n0ue8uk+6zMPiz8sTW9CqyVY7IBJvyE6kkQG1sFI5SuEQCMNjyATMKSqciIPHRlIfjSE
         r8XA==
X-Forwarded-Encrypted: i=1; AJvYcCVASxstNPE0n2dRPt7KtRhJOOQ54XOdJweRsgHA8L0vklLTLsIvn4M2HvGuqPJDD+bgRnmotQSfXtmnGpz+Xg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHyfOMgTk4jrvUkK5q3pGOvHA5vq5b7oOsr+Hce7MpJ8flZX1p
	lOJcmKSpN6xHSsyVpkv96e22xP2WQqlc/E6eLgspqn8tUzU8HpboFg8mf4tLJ7UXgNexF0L3JNm
	EVzi6VUg+0kjnLACu3/QnR1SW9GrarMAaPMh3skz7WOXt/Bp88aMEBm5A7G8Y9TqDjVyQ
X-Gm-Gg: ASbGncucVTOTYBwRZHHyQuLv1UZjGB/PoNDIp/VufUluBG1yFyj3Suej8jjLR67qurp
	gBJ92/eagUTtWqBtB2Q2m6WVfPSKLzav1AjEEfAqBiUurR5Vdb6HJSAaovZZZAHgxTOEf+Po/c3
	SYbx1n/8wD0LLPVW9ZWwt0Z+DzRNRdUJQErVlmjugSr17rFN8RRkai4F/H0D6DXJ/DKU65DIIJf
	vLjxcqfhyqADmr5zL7PcA7YmDrwyCkD87QoafqB02Ew6Hj3qHDxYtRL5UqcN3nqpQJ0WHXbAfW4
	dK+3CYGyMPzUdWUjQ4+kdfFvGAg=
X-Received: by 2002:a05:600c:c11c:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-454ec146a71mr126236715e9.11.1752601061313;
        Tue, 15 Jul 2025 10:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEav7jSZeI2X7Lu4R457llVbI4CiXULRrrPNd8TKiDciKzpga3jeaECrjhf/ot1tIBrxWWMDw==
X-Received: by 2002:a05:600c:c11c:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-454ec146a71mr126236465e9.11.1752601060964;
        Tue, 15 Jul 2025 10:37:40 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5050d34sm209336735e9.9.2025.07.15.10.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:37:40 -0700 (PDT)
Date: Tue, 15 Jul 2025 19:37:37 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-ppp@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Williams <clrkwllms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next v3 0/1] ppp: Replace per-CPU recursion counter
 with lock-owner field
Message-ID: <aHaR4QzKvCDi/LYx@debian>
References: <20250715150806.700536-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250715150806.700536-1-bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pVbDBQjJ8LnhSapNuQxOVHmkz4g9wT98sBhI4mjQSQ8_1752601061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 15, 2025 at 05:08:05PM +0200, Sebastian Andrzej Siewior wrote:
> This is another approach to avoid relying on local_bh_disable() for
> locking of per-CPU in ppp.
> 
> I redid it with the per-CPU lock and local_lock_nested_bh() as discussed
> in v1. The xmit_recursion counter has been removed since it served the
> same purpose as the owner field. Both were updated and checked.
> 
> The xmit_recursion looks like a counter in ppp_channel_push() but at
> this point, the counter should always be 0 so it always serves as a
> boolean. Therefore I removed it.
> 
> I do admit that this looks easier to review.

Thanks!

Reviewed-by: Guillaume Nault <gnault@redhat.com>

