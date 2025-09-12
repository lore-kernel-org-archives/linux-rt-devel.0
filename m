Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4691334361
	for <linux-rt-devel@lists.linux.dev>; Fri, 12 Sep 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711596; cv=none; b=D0iLMMUeS4uquL7d2R0I1QAjNRFg5jE6Mpktff//yZzkIf+UQy87268/nii9WE/PwqUXbUL5JCP5X8JoaCM0dtkYVCNSVcGdsk3bJq5DVyMLLEsjH7HywmwaRbI8rGwkjD8KHBkndad1a7TMYAwhoJ1IIXaTl19S1boHi4+IbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711596; c=relaxed/simple;
	bh=gcaCtOTSXV2XbJKiE3q73MLyt7PVw58fJiPF6uaIJog=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gfMTKtoQoRzbI9iAWDitA1V1QITu3t9NEib2Sbh81eR1iRIWM6cvmwuWUXMdD7XpCpC1GkV/1Sn68VprBmsNNXF3s9T3uaUc95JeQcNVrmOj4N9CpRiPOhL+lffiwOuBHppa9iDMTaqfqoDlBWLKJ9WSydSTgPeSHbAAJR/jsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfYhH89O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfYhH89O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757711593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
	b=NfYhH89OCJJ9xV3YK+X0hGStcpwCW6dgEx1kbuEcNjmMn5RA/OA7mGH8ML5bCINl2kfysG
	Lk4h4sXEg3CO36ZiT3Tgw/m8GHKWbNU/OVyoCj3XD2EH0wDn7i7M3gyYzfInuL1rgLFwo9
	YhK01U54ABsgadSsPFOnWArTY1bAsfI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-37SETkZrMDSkNxz0eZT2iQ-1; Fri, 12 Sep 2025 17:13:12 -0400
X-MC-Unique: 37SETkZrMDSkNxz0eZT2iQ-1
X-Mimecast-MFC-AGG-ID: 37SETkZrMDSkNxz0eZT2iQ_1757711592
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b345aff439so68471771cf.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711592; x=1758316392;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
        b=naE9oRlRWhEB9nHtmvXbUQn8blm+IvZqo6FGuxReUKx9r0Wql4MmWCvKeDDhMpfhX+
         WAYH8sdBJTZbZVSMXH84MFI3fT6QtcZ9bTZAR3EV7+gHeR/Fq046yAhQcnvS/1Yw75qZ
         dLY0NS0u4fRaceqn7lVygb50VfEh+3u7Gm+kkhc+rKaGFGua2HmUpbEcL0uBAo1C0A86
         Veoo26fdo+KAQXeY+Dy/4RqsJfNR6c+VzMOHc2DNa55g2iBLquuHWMZk9lIirFLI+0eO
         fSje+ixgKPGgRxoqgGPyDbZfX1CjQlt4rsoOD7Trx4ejtoAO0ZOFAIke8X/MArXtmMcJ
         kyfw==
X-Forwarded-Encrypted: i=1; AJvYcCUcE8S3A10UeEnuqlC3eyhuf381A5qrWqNiX1EHXoGYyq9zIfM8kCRKZrm/kiOMKbye6eSkT1PtyEkYXqF/fQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrKfdJ992dvMdbb8RI6LXoOtamd221AlrW534fx7yNNLjhxVLH
	14JqKkNwS5CXWu/saMDbDHQvH8gv6r3Iof1YebAda64b0eVNWurEBtWqS5Yyp9Xkbczju8Ctdz/
	GeI9JgfWs3URQkROHxnHyvxBcOGKBUrLC5bXjmQMuIn/dJQpp77vUktjn0lO+sRD/MqDZ
X-Gm-Gg: ASbGncv4X3yi0+VxIPE9k+oRUe4qR/CIjsiXmtC/MSlQLzS9ItYImnevw04BOrb8BIC
	C8aJhGXC7mBi3Aow8Q/+zqKX7ULYG/LWg9leVRntMEszTpa3jdkgPop9Y3Gg2koPhY9xw99I18z
	DmrLVFkFAY/mqw5pTEnNNTeKhQsSBunj0EvYxTxCxlTTYKFj/aAQV1KeKvGdveKIFE2srocNB5N
	zJjaS5di3QbaJWrucU2ewXpW1g19ZPR5xN7gWa11MULbviJLfyYJqYReKDq0vFtAXG1AFr/BL0N
	DYE+c/xnoYNPIoTXDmJrPJu/iEo0I/Y6h2pOc7UY5g12QZ3CeHb0cRiAfreyhIDrwgc9tzn0OPd
	R+yJ7BixZIg==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549461cf.25.1757711592211;
        Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMw9fpUjKztDhFj7vngF7IcasgotLQXC7Sz/FG+fDJqIxlNqO5vbKN00AADMBFHKIX07xTcQ==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549191cf.25.1757711591843;
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab102sm29277371cf.33.2025.09.12.14.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
Date: Fri, 12 Sep 2025 17:13:09 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
In-Reply-To: <20250912065050.460718-1-dolinux.peng@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kv5Ffcgq_Y3eF_GTPwZ4DbP_WJQU1gQX73WxB1c5KK8_1757711592
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 2:50 AM, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
> disable preemption, which provides RCU read-side protection. When
> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
> manage RCU read-side critical sections.

I have some doubt about your claim that disabling preemption provides 
RCU read-side protection. It is true for some flavors but probably not 
all. I do know that disabling interrupt will provide RCU read-side 
protection. So for spin_lock_irq*() calls, that is valid. I am not sure 
about spin_lock_bh(), maybe it applies there too. we need some RCU 
people to confirm.

When CONFIG_PREEMPT_RT is enabled, rt_spin_lock/unlock() will call 
rcu_read_lock/_unlock() internally. So eliminating explicit 
rcu_read_lock/unlock() in critical sections should be fine.

Cheers,
Longman

