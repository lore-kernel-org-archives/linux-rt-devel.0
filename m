Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF86328B4F
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Nov 2025 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336075; cv=none; b=a3RQmrC1cLEBvAIfeLDrKDNjvcdbtUnGgxN17elTd8xisK7BMDCTrdMZcN4WE1un7J+nJp6SPGIQ8r1La1tPSIxltO1ko+5CmktGwF1GOKRNbriz0gmwQaSDUwy8IcvbeJ1WtE8DZHf/oL5730M0oBNi1yb5Xb5SSjofoGMDADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336075; c=relaxed/simple;
	bh=DsEJcGvoOKjIC45rLZGaMsZIxLapEFLmk4cH/20t8JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpcmzkspiJLrpvKtp9tFnlbEAVp/gqQ6dRzHhk71H+pcHCOF3Nt53mttdZpwWGvCvR+Q2vTWQj/Jm0LltkfWCZKM5Q8Mwc2Y10O859pBsgAEc7OYQ1WDR/ko2hXHZpUxc/TV31aZvNJmdJWV+ErKx1Ud12pVvEqQPztBZp85mQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cprpH4rk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cprpH4rk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764336073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oQDcqy/qOpm1gMgRt3E1vC7ZA48AfJnGVoTbuMyXv+0=;
	b=cprpH4rk/C5IULC+WyZkiHZ6mpmsmJ+IEjpZllfMa9MnlZqD4q7lXkFC7THhD5dSQMC0I1
	sKdXuxnOUe1Z0YSjls/glIkb3LnkMjESQkueHooIEFpp6Mg9mNkpB5pDHhqYGY4Zf6eCym
	kw3iNTss1N4YgN5xlh7ouXGJsysyMLg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-K0tuVoLpNNycR5eRElBcxg-1; Fri,
 28 Nov 2025 08:21:09 -0500
X-MC-Unique: K0tuVoLpNNycR5eRElBcxg-1
X-Mimecast-MFC-AGG-ID: K0tuVoLpNNycR5eRElBcxg_1764336068
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8156C195608A;
	Fri, 28 Nov 2025 13:21:08 +0000 (UTC)
Received: from localhost (unknown [10.22.88.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3D4018004A3;
	Fri, 28 Nov 2025 13:21:07 +0000 (UTC)
Date: Fri, 28 Nov 2025 10:21:06 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] debugobjects: RT related change and noch annotation
Message-ID: <aSmhwvZ6xghifyaM@redhat.com>
References: <20251127153652.291697-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127153652.291697-1-bigeasy@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Nov 27, 2025 at 04:36:50PM +0100, Sebastian Andrzej Siewior wrote:
> The first is a repost of
> 	https://lore.kernel.org/all/20251106120628.AxWa_Viy@linutronix.de/
> 
> the second is a fix of the override annotation.
> 
> Sebastian Andrzej Siewior (2):
>   debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING
>   debugobjects: Use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP

To the series:

Reviewed-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

Luis
 
>  lib/debugobjects.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.51.0
> 
> 
---end quoted text---

