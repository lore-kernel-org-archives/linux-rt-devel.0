Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F687199230
	for <linux-rt-devel@lists.linux.dev>; Sun, 11 Jan 2026 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768172543; cv=none; b=Y4pCee0ZBzxoJ2eQLPN08aZSwqYHqvqJ33ovzZju8Za7XUonynIqzG1jfxnR/mbMhxtqZKz9N2D14vM9s6HCHrDew2aoCETzcpzt+L7LS/C86GqdpJJlvDD5Fu7QWo47ncNCEyXRDVOfePkD0fUGtasZbB49B0uCe1p05Nc/J4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768172543; c=relaxed/simple;
	bh=/Asry4sWCVFSezSLmLDikar4I8gBaY/eRP7gdkescxU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=afjOAWZPeTJwHng1ALckPw1yVaapb6QnCKoK+oBvI5lH5cGbDERdi+SUHoFJsoQFXtPf7z7qiNbrCm7UAn8f5TsSgp1RaS58goBAKS13BLn8gcwfStrOi2Bg70BnddhdKOtz2BQrkw+ONjZzxkYZ69tMkbuyUPCjar2kjir5neA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvcWx2qB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvcWx2qB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768172541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zv21RsZEoVv+G7aoKZTUN2Xu41JrxyNGBt1z4w/tEmo=;
	b=gvcWx2qBeaBpfrCGLp4n5hrOFo7lnuIZQbHXJ3xEE4+cr3Epe2uvJW2xEILw+qP7Tvy9Pw
	CY43OKHlbv3hMrE10RHlvgTLvSPkNSvORRW6IXilgxSj5YK3jDFdqX/j4fKsihP2JzCciw
	1HB+Y2mg3RnLMYA85bAU4Yjvw4ssEtw=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-cFo1J3laNEqU-GD-yH35nA-1; Sun, 11 Jan 2026 18:02:19 -0500
X-MC-Unique: cFo1J3laNEqU-GD-yH35nA-1
X-Mimecast-MFC-AGG-ID: cFo1J3laNEqU-GD-yH35nA_1768172539
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56366dab014so6048939e0c.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 11 Jan 2026 15:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768172539; x=1768777339;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zv21RsZEoVv+G7aoKZTUN2Xu41JrxyNGBt1z4w/tEmo=;
        b=Yj8bxyc77D6ltDqk+ohRRWM/ryVhYyKCJa5lvLRK2eIgyddYaPogBNRZgZ/a9Zj/aj
         F7PHk6HWQS0yYBIrmUbB6Qiq54BBVTGe5McbVlYE2q2Bxb/LfoJqRIdN78TorYDUSyli
         PNzPuRnI0/l7/3uLphjhUTNt2PsQIq9t/IQJfQSXk2zzT7o+42uA5FiYff8zhkd0hd2s
         RG7CI0I7PjFW1erhmWzMzE7O9k1Jo2r2y89tmzEfy2pSJFNlvGGiGnW9XL7+AmviuVwg
         4K1iqswPhz5O8N4KvPPU6kJ7CPeTf89N+t/QdDiixdlJ8nRUJXW3pOX9AXe3dVuAbZ2U
         5cGg==
X-Forwarded-Encrypted: i=1; AJvYcCVg8SxdxApPlZNDv89rZBmniMa8EuHrPGH5ymlqkCimutMfG6mZRv87QXmyNwaK5Fk2YYEGvQ+LkUryIfB8YQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxESBuZ/f6VhnpobbIJqQI6L0etsemZfjXw1HyZL/9vSLxnPIm1
	xBHVppVxqAI+VWKfuXaKoh843oYl/jRVyxQUDxA+TicYjvLBL38kbwPiQhTcmurcjAY1oI5JtiO
	/HEOvTwonDstYno8XHbrVvOljNNGZBeZu1Cl6KRxzfmjAQ9ErtrgqZRgNBbqkk28OFz4y
X-Gm-Gg: AY/fxX4/ngA9Mi078aRzzs484GX5DOm4phjdTu+1e5dtB7kpSARSB55nn9RWgdwiEc8
	Rai9/RB8UeXHfBz1GB6atIRFXvuAFMOAjQAcasagWuELtcj84HmqXUaeoXQR8EVNIiI2EIQQ6aC
	O4IBypL2Ci3C35HPa4HTQGxx3r9uJf8BPlBWZr5bWqig8NkCWDtGUWwQlKw0hSFPZdRWf9aRjWl
	xW4rD8dhf6ymw4M3ak2pQl9WRZqrpoFJtp7ApFKIL1fo2/Lk9KMw5Cp4OJl6OUoPyg2BKXqMbz4
	6ypS04Rhwt7+bgJz8Vs9VfyLGQxGsDMBRxL0RHDZHVpbj6SoErtk+omI2hLQdE5s/5jA7CR+HF6
	ebeyfNvefc1XP2zZN5Id3TOeqLDze9ZfcClGwGYHVsTg9J/6zQkIbPESw
X-Received: by 2002:a05:6122:3383:b0:55e:82c3:e1fb with SMTP id 71dfb90a1353d-563466b1471mr6262657e0c.10.1768172539002;
        Sun, 11 Jan 2026 15:02:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOk4sm334yhP3hW+Z5bab2iMBbiknbbF0VXPQa3QhngNtcACSCZZbMFOiVkS2ufPcqrvXiIA==
X-Received: by 2002:a05:6122:3383:b0:55e:82c3:e1fb with SMTP id 71dfb90a1353d-563466b1471mr6262646e0c.10.1768172538549;
        Sun, 11 Jan 2026 15:02:18 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5638821427dsm850204e0c.18.2026.01.11.15.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 15:02:18 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <40cec799-f363-4642-969b-24f5a2d56dfb@redhat.com>
Date: Sun, 11 Jan 2026 18:02:13 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <86v7h8l9ht.wl-maz@kernel.org>
In-Reply-To: <86v7h8l9ht.wl-maz@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XFmky3wn3qbOPXpdEOGLlCkZlXkYP8WigFyGzNw-Jvo_1768172539
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/26 5:38 AM, Marc Zyngier wrote:
>> Also that patch seems to be incomplete because there is another
>> allocation further down in allocate_vpe_l1_table()....
> Yeah, I wondered why page allocation wasn't affected by this issue,
> but didn't try to find out.

The use of GFP_ATOMIC flag in the page allocation request may help it to 
dip into the reserved area and avoid taking any spinlock. In my own 
test, just removing the kzalloc() call is enough to avoid any invalid 
context warning. In the page allocation code, there is a zone lock and a 
per_cpu_pages lock. They were not acquired in my particular test case, 
though further investigation may be needed to make sure it is really safe.

Cheers,
Longman


