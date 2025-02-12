Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00720F06A
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369515; cv=none; b=CsLSflP/wCVwk4VHxuZqMYAbAxMKZyf5Lg7aOhRgxsd+vH684NAUp6B3r/TE9PnHbq4sKUjGc/4SgoXg3De9/VgS05EaYHIA1BffNHv9o11spvgnqmSZjGrv9ImwmNAm+xuxkcjkyA4tjTO3vRAkm7qcYIJh3YgZJ+6q6DQcU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369515; c=relaxed/simple;
	bh=7lOc0ruExiQif30p007BjylF8cs6Vx5b/8b7quCgPYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgkG8j+GlKaoCEV70zsc5p/0UYt5s654QO6iaHwsMq3M+8EvDShfy4y1CuBnXLHi02sg5PJyh9P+qedtNtHa6m1CYBF0KnS3ckRR37/PNSYzIqS8Q6O4WZKWkaE/kOQlw7flSBZ1+o23fs3DsF2zl/KFrMzGmJEFi5KWG9VgFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcJ2ipt3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcJ2ipt3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c8cf98bbso6755645ad.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739369511; x=1739974311; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0tkLisKyCAJk/GTfjcId7DbkQwyWicb7CEmJ39+9v8=;
        b=gcJ2ipt3ZU1CHlpl3k1UzjIkiPNKiH5YjTXsYhhWRUl6KLk++EVJOzwt2aOxZaqRVT
         +z85dKVVSoxQLfIU1PvgmHwFKjxjc6dYViY5QwJb7EW0Ml8nKx2KNuROXKtjO9pyswRr
         yUGqABPDGWisozgSWHNYYBGxwVySejGRbeJGkbgAl2Tvdg6E52r7Y1D6a4/9ADggRxx0
         KgV5zmOh6Hm0cqDZyVaJ71NE6dF9iHIBoX8ONRzYYQqWb958MLucSnKP/RqBv2BJMkQA
         a2AKNfHP97cS3H2CF10t7fe7bettSTAIQJlK0fyxwlx+DGe2clOs4qSwYOALB2hL7VdM
         eRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369511; x=1739974311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0tkLisKyCAJk/GTfjcId7DbkQwyWicb7CEmJ39+9v8=;
        b=ixzmxH/hKUjTxNxQKztX6M0wy+1y4gvCj6ni5j30RIVxay/g2LWrpWV/UqxQkib/EZ
         VGrbHIKVmTssgTttu2TBINjEwJLAmHWnIfqiKyFojcA+SAGSQOii0H+5McrMkfTTc9UJ
         iHxWMQsf7s3gezp0Y2Q7PzZwRUhNS84cn4O21isaEbg8NeQJIh6nwgcbg6yMNM3qeikI
         oE0Khj0Z5V+S/GacaL/2hahgy+tRYLWYSDybbx1VaWWIe2BKNqNT24nIvhGPsZmRmlry
         1tpJrc9rBAqE8KA+2LK9OQLsckxjs1x42CIdze8/8BXu05W7Oi43I7WMzEPahJph3O+3
         I+QQ==
X-Gm-Message-State: AOJu0YyUwvkoMIKiniYpYBqsD5SxU97Kv+Pe4yWZzlvu0B7eLZZdyjR7
	V5CK0fQJ18ANU0kZLMlrHGfyTEkLw/nG8v6PrQhzUoV1wraL3+IO
X-Gm-Gg: ASbGncsNwu8gHNqyvvSfx5zngAgeLZd9XRTSLAi+iLzWDNJSb5AJnPbDwK8e9bwHtaI
	up5iL18/5zhPaVQOC87RVez3tS4PMNzpkeT5Lq4sbvnw3iwp7MxU3jcEqC9lA+2uHFPQ76VlGyo
	2sELEjk0FVXYRVjof1ymII8ZzF354hHTVquq2xkhtMBV+94PgVa7F91msxRDFiWEBzpK+upFucJ
	6swm5CRg4B1kRRR4XGIGGmalgBm/g12ml0Y72pLOUGs6HpB6s0ZdQOe8jaY45Gk8utV41+nH1iM
	eJH+LxVV3Dp1PeKfwJSsxOsb5ryH
X-Google-Smtp-Source: AGHT+IETXXt55AF3BS8Q/SxMhDT7/V0qdZbeRX07hF+De8jLBRthG3OBLKLNEFgHnNjV0zL6e6/Hww==
X-Received: by 2002:a05:6a00:181a:b0:731:e974:f9c2 with SMTP id d2e1a72fcca58-7322c0a00b4mr5240374b3a.0.1739369511452;
        Wed, 12 Feb 2025 06:11:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7321b34c003sm3317040b3a.52.2025.02.12.06.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:11:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Feb 2025 06:11:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] lockdep: Remove disable_irq_lockdep().
Message-ID: <5c680698-2385-41bb-946c-4471f23554b8@roeck-us.net>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
 <20250212103619.2560503-1-bigeasy@linutronix.de>
 <20250212103619.2560503-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212103619.2560503-3-bigeasy@linutronix.de>

On Wed, Feb 12, 2025 at 11:36:19AM +0100, Sebastian Andrzej Siewior wrote:
> disable_irq_lockdep() has no users, last one was probabaly removed in
>    0b7c874348ea1 ("forcedeth: fix unilateral interrupt disabling in netpoll path")
> 
> Remove disable_irq_lockdep().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
