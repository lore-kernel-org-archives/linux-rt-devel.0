Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624942C11E6
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310873; cv=none; b=ao/bLrOdkGziroqE4UevP3xlam999qvtDUpw2uUZ8Qt5Ku/K8kUgy096IJr7wWVgOvOvutSgGwAqbOqNDIlbKZ0JltlD1o1F1RQVL32utpQtVZeqzR9EnNxRsezhKKND4L5lGP0h1obxwhBS1G4MIxBcCAgNu5Qn32ZkBAb1Lxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310873; c=relaxed/simple;
	bh=Ut4MVfPItw5+L3CfrWuazydvYIZQOlZKotmRfjX7Qzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqycE4ebOOfAkhDRYJz8lNu7PW9JS5ezBFAEvK02FlsKy35Kl+Dhp2yRrh/C7Y9EcP17SMz1+cHM+ADxoI/wCZ0j/H6YsmMO0MAq6rG3xPgy9TxJIaclCdPZIH10y4nGSYeHE9oYW+fsZabJ0+5PpNRjw+h1rF/q4NLttGs2M8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJD0+d4B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJD0+d4B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779310871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9naQ89cY4pQ/7RwTVxw5SYdLZz0THDHbZBMU5d/fMY=;
	b=TJD0+d4B56oVlJwQ05c6gJngecR1gqHmqDcYaofoFXwQoupUjOs3eTfZoZ8Ln5a+AatiUi
	DkK/VQKseq/6OzuKUoYWuS78E0/2hYkkZqPCRqPfNbr+xY1GSYvY3AidfCu7+C98qrVAqu
	DWBaowPxI/WCkUXlo+sk7tsMPDDWp2o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-JLNdvWNKPyeo2y3n-bNvQw-1; Wed,
 20 May 2026 17:01:06 -0400
X-MC-Unique: JLNdvWNKPyeo2y3n-bNvQw-1
X-Mimecast-MFC-AGG-ID: JLNdvWNKPyeo2y3n-bNvQw_1779310864
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0D2A180061D;
	Wed, 20 May 2026 21:01:03 +0000 (UTC)
Received: from [10.22.64.248] (unknown [10.22.64.248])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 684DF1956053;
	Wed, 20 May 2026 21:01:01 +0000 (UTC)
Message-ID: <a5251664-2c15-4a8e-906b-d204e10c38be@redhat.com>
Date: Wed, 20 May 2026 17:01:00 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/entry: Don't disable preemption in
 debug_exception_enter() with RT kernel
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260519222524.886454-1-longman@redhat.com>
 <20260520061920.XCqBHe0x@linutronix.de>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260520061920.XCqBHe0x@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: ieqVE8q1vEarwkjJYzlzdx_4W-VDjYbXNO98zPU0Wj8_1779310864
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/20/26 2:19 AM, Sebastian Andrzej Siewior wrote:
> On 2026-05-19 18:25:24 [-0400], Waiman Long wrote:
>> Commit d8bb6718c4db ("arm64: Make debug exception handlers visible from
>> RCU") introduces debug_exception_enter() and debug_exception_exit()
>> where preemption is explicitly disabled. With a PREEMPT_RT debug kernel,
>> the following bug report can happen.
> …
>
> What kernel is this? I have backport (which is being tested) for v6.6
> and v6.12, the patches are from v6.17-rc1.

The kernel backtrace is produced using the latest v7.1-rc4 kernel. There 
are a number of changes to the debug_exception_enter() and 
debug_exception_exit() functions over the years, but the preemption 
disable code remains since its introduction in v5.3.

BTW, what v6.17-rc1 patches are you talking about?

-Longman

