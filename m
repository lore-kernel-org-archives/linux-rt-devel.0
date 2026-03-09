Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969935DA79
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Mar 2026 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083176; cv=none; b=a3DLunoW71pdXU+hKPGZ3qdj1VdXQwczwjogsGsHoSnVikfM3pNgZFY2CRjBM1dSDkTUkPg0/MriqrKHOQf4aRJ1HY0TvkOoIgniozlDzoVpa6Kdu3+F7GYm8MllSR1wB3jyf79PIKqmeadunGNceoVc3zR/dAUFpyqdvsip/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083176; c=relaxed/simple;
	bh=drOuKHOm4PAuF2Z67mKHYeqeTW7a5tlK2W5PJvTvIQ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=g23jT7TmEpphK43wnHUkQBv3AWrsp233cG47rjB88TmJKJFMSeLrTtSoqNAZpRWKs+szx+JUG57qCBq/i19ZQE/QUsNQ+VyFEe4NpF3kBsN/IT9WNkEr5arlAgEi/Zs58PBWmI2+BZ5hx69uk4kmbaomF8kgeMgKbITuczQAIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EspfRclK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EspfRclK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773083173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5AT7sE7JqfmniCrKEncpeQk8Mufi8uWIdilz523/Oe8=;
	b=EspfRclKrm6Ssa0jlCGif3O/omBqFaQ2sFjXof07KHClA87Q558v8QFo09ddvk9UgMPWZG
	9bv6YcK74Wwdze53a1fWKU5X2HWUlZfcvOoZXPOP/dHAZS3xeva0Y8jG+Eoizcfl/iA6kX
	Vwj4Qj8P/0dvWR5VtDfjL8IJwLd0cRQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-hQ46vRkEPR6KWI6-ePGIFA-1; Mon,
 09 Mar 2026 15:06:10 -0400
X-MC-Unique: hQ46vRkEPR6KWI6-ePGIFA-1
X-Mimecast-MFC-AGG-ID: hQ46vRkEPR6KWI6-ePGIFA_1773083169
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECB3180034E;
	Mon,  9 Mar 2026 19:06:08 +0000 (UTC)
Received: from [10.22.81.138] (unknown [10.22.81.138])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94D771956095;
	Mon,  9 Mar 2026 19:06:05 +0000 (UTC)
Message-ID: <0a332e19-c99e-4dc5-a2d0-b36a2aef80a1@redhat.com>
Date: Mon, 9 Mar 2026 15:06:04 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org> <87ms2nsqju.ffs@tglx>
 <86wm1qlq7l.wl-maz@kernel.org> <87ecnwij44.ffs@tglx>
 <86v7h8l9ht.wl-maz@kernel.org> <87pl7gglya.ffs@tglx>
 <86tswrkrh4.wl-maz@kernel.org> <861pjjcqdi.wl-maz@kernel.org>
 <4dc6ab03-b2ad-4411-a49b-4513c5d592ea@redhat.com>
 <70dbf293-dd5b-4d77-b653-8f8c09129723@redhat.com>
In-Reply-To: <70dbf293-dd5b-4d77-b653-8f8c09129723@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: YlmvgiEdTjw5BEx3oiMxKNxqlYjnhEMPvBJbFDP3QKw_1773083169
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/26 10:49 PM, Waiman Long wrote:
>
> On 1/21/26 3:41 PM, Waiman Long wrote:
>>
>>>> Waiman, can you please give the following hack a go on your box? The
>>>> machines I have are thankfully limited to a single ITS group, so I
>>>> can't directly reproduce your issue.
>>> Have you managed to try this hack? I may be able to spend some time
>>> addressing the issue in the next cycle if I have an indication that
>>> I'm on the right track.
>>
>> Yes, I have tried out your hack patch and the 2-socket Grace test 
>> system booted up without producing any bug report for a RT debug 
>> kernel. I will try out your official patch once it come out. So 
>> moving the memory allocation to a later part of the hotplug bringup 
>> pipeline where sleeping is allowed should work. 
>
> Attaching the dmesg log for your further investigation. 

Ping,

Are you planning to send out an official patch soon?

Thanks,
Longman

