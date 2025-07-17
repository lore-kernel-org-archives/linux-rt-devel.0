Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E22D8799
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Jul 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759621; cv=none; b=p7epd5HfKiDwfMWBgAH6h0pIUgwteyp8SyGvlfkROCrxtlqLLVycCYPQ+vWRwsMSPYNX8aUCfwRboqRTg+O+ODSuNjhVnF+MF6uFbbqeQ4EC0eRYWOXKCl0n01xBk7ZsMyk18t9Q1RxeqPUVUZjC+OsqpcZfLeAwrgsW0rukogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759621; c=relaxed/simple;
	bh=LuQfGUg7QimTZtMM6kIrGixSsVqH0rbo3bsIbi5btEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhTg6pqOxE+Q0uWXcKNtLmf1XANW9mKlqnDhKvsuYaKIC5Rhtl//mimQpNAP3p32UAS0uHV5orMcnyYaRekdX+vkFIZOQDPwKstGRRAaW6WV/Hm49AEBuVqIDLoy60DyoxcsUqxw9llN6w1yYWUqGKnSB9MGOnlxbamrcefCIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZedEVwt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZedEVwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752759618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGPfxbk6jNUxyPOfM4/Z2ZLLJNVNzX1A59T5q3qLXtU=;
	b=RZedEVwti6p8SB4sGZgiN6q2g96/cmAG53yxmZBAGno7dAC7ylolJ5X7+AawR+u1ymOAAY
	qILXKOjfSLqcl3qN4qxfysxQwflplp7rCPEeNXuQdzbzIVPM+uX3cg7qZF3Z7O84mK3HQ0
	6Itdf/p8iWtletpAf3sN0iNWRMNvW9c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-W8iDqfBVNkWBKxXS4VYIHQ-1; Thu, 17 Jul 2025 09:40:13 -0400
X-MC-Unique: W8iDqfBVNkWBKxXS4VYIHQ-1
X-Mimecast-MFC-AGG-ID: W8iDqfBVNkWBKxXS4VYIHQ_1752759612
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b5fe97af5fso427521f8f.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Jul 2025 06:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752759612; x=1753364412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGPfxbk6jNUxyPOfM4/Z2ZLLJNVNzX1A59T5q3qLXtU=;
        b=wI+KoYqWBTn4tr10XCRANWMnph+TFqyksIm+vJmeJodpos7PBTUPJrZtNrujylQE7v
         c1SbsBYsCimWauUF5DohXaBh9KuWeRe686XiWTV4Pvh7SwkIQrNyI62SAZn91g/XY+VU
         bxIygo8+shILoUxMdqq12roOPaLeWLpDIXxLa7Ysx7wliLzq+hrg/ManI5QcT5/HLyAq
         j2l4FlD0KowIX5Xk+rjddDQLo5gY53lrurt41MM/aVowunXBBx4WVOW/xduBZy3Cbs3D
         9i7XBgXu8nAYhGTOd2Mqiar7+M6p5Khm1hYsgiFVYXJLV6W2iLHQkkgs7f6DEO7z25UX
         XZjg==
X-Forwarded-Encrypted: i=1; AJvYcCVFLU2u3vJeYpJ6mDmDzvdC4BkoXoquOB6ttFubqsAzdkjD6hZL0Gflgr3f/Og3AEVElsK2D90El/PCbLQAiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvvYVPo09v4Rrqfuoa5l712QwNwWigecq/8fTqh9zQ9HLzTzx3
	CdiL3DQ79fnxIA9n/gGTfE5mpuP73t8tJRoAWar9A6kvnvvIexpTD1QKMQtPzVQzlg6sn0cS7yx
	wdWljKDbajbDIyNXqnzNhavMGak+9RrGsk6mAr7HpQXI1MU+ykJp38j/+sL/qEk5qrpmV
X-Gm-Gg: ASbGncvww7okOsMCqTPk4AE8K971NPLsLyItjSI/e9hI9kHh7pMWxOQF6OBUHIuWLNq
	d6/D2FkgryG9U4De4BDmvngVY4BO9iGIG2DLrNUf9iXSGHe8XBqmYvZr6CMeVn9xOwk78Gql2P/
	2nmPmalb3dd8RwVB3CYqn37r96ckx/VCiWBpK/HFD+LjXyEjvfMRrRhc98lRDsRAKxDJMAdDW/F
	6fNUIktlKWP7syHy7K1jS1VjA9QCPQDVb9CF1bMNGoKBUf2/ln4IIwX77Js0+C9QmA39tPi3C7s
	Z7QlRH422rqyXO+r4VM7wRhyAgmXJabvm2S1TIk6ti7PorYGcU33P0BKYIu8f6QW1zGSgfHs/tP
	vRp0vNtypUx0=
X-Received: by 2002:a05:6000:2002:b0:3a3:ec58:ebf2 with SMTP id ffacd0b85a97d-3b60e4c4915mr3929307f8f.7.1752759612430;
        Thu, 17 Jul 2025 06:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAIardHgYCQYeh4W/Z6kkN3By8E1k+FByZrilW0zMomhGnQ/6ioH/KXKgCzHgSbmluM/sr9w==
X-Received: by 2002:a05:6000:2002:b0:3a3:ec58:ebf2 with SMTP id ffacd0b85a97d-3b60e4c4915mr3929281f8f.7.1752759611988;
        Thu, 17 Jul 2025 06:40:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5f16a6016sm18837512f8f.69.2025.07.17.06.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 06:40:11 -0700 (PDT)
Message-ID: <68a3115b-8ae6-47bc-aaf5-b38e4f83c5f9@redhat.com>
Date: Thu, 17 Jul 2025 15:40:10 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/1] ppp: Replace per-CPU recursion counter
 with lock-owner field
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-ppp@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Clark Williams <clrkwllms@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guillaume Nault <gnault@redhat.com>
References: <20250715150806.700536-1-bigeasy@linutronix.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250715150806.700536-1-bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3dkh1v7pjQPhbd9Ux23ElAJK423Ygd1ePRgTfhuvcIw_1752759612
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 5:08 PM, Sebastian Andrzej Siewior wrote:
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

Thanks for reworking the change. I do agree with the above ;)

FTR no need to add a cover letter to a single patch series.

(but, since the matter at hand is IMHO non trivial, in this specific
case I'll preserve the cover letter)

/P

