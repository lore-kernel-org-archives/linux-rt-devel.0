Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57256322A24;
	Wed, 31 Dec 2025 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767184507; cv=none; b=t38DoNWhHhOnLP9IRHlQ+QNxm68ONwB/aoWOOZLFdGcshxeebfion/QtpRDjQ8dCj+pE9uMXe/SwBa6IuegCkL/PDEI1QlgyOrA6g0MCBc7Ve1NMnRoJiO6dEWyEmWzYo4PoLELLCixJ1k2lFM3mNWZNrIMSqn0wQt6/7O0zlG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767184507; c=relaxed/simple;
	bh=B2M4WvvAxNt5x1M84qRGbik/E/Gxr7wlXrZRggc2PAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNt3Q/bRr+t/ocPtz1pxmNldPZ/+E8sMETTXidsWIr1RQfvdYE12rRq0fwCtitfL7acCmVYU4fXnxFiP3lQHLP7zDHYt4CDAEX7LWKhIDEd/ZQKfVkh/6DakNcELaKmBRMEli5NQeY3ygt9R2BCQJ0uQDxh6nvy8aRVHU4Irc1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf6LIZSx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf6LIZSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662B7C16AAE;
	Wed, 31 Dec 2025 12:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767184505;
	bh=B2M4WvvAxNt5x1M84qRGbik/E/Gxr7wlXrZRggc2PAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pf6LIZSx6Ze7BTQt6bjPYs+oIBAP8LGmLSf/UCB+uZUS3xPmdRiSt3fPX/FutRGdy
	 Sbo6GXAMPIghiN84OFmXqKFpg6QAWSeMLQVWLa02mdu1NhKY+rCc0aP+z4t+4qVKVc
	 ESF1+ovbuEE9T+bsVUPf1kRnegeFwYrFTlXkLd7/J6Q+2YoGikUIYYnWl4IrC3rJQG
	 H1Vr7bM7t9f17grPGX+FVNBv3WFtSxDagLFaCVKKqiHWucp9G7m1HSvrhIoH/N8ZrM
	 1EbuiKZNYpZBs8MkHZ9Ex2QqHTH528ABYAzTtPsyH9UV+GwhnuXEGeLBUimCvw6WNf
	 vhjhxPGx38V9g==
Message-ID: <d99b100b-0262-4f57-aadb-c16fea47e6cc@kernel.org>
Date: Wed, 31 Dec 2025 13:34:58 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] fix wrong usage of memory allocation APIs under
 PREEMPT_RT in arm64
To: Yeoreum Yun <yeoreum.yun@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, ryan.roberts@arm.com, akpm@linux-foundation.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz, mhocko@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20251218194750.395301-1-yeoreum.yun@arm.com>
 <aVT15bhN4hEBNaOg@e129823.arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aVT15bhN4hEBNaOg@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/31/25 11:07, Yeoreum Yun wrote:
> Gentle ping in case of forgotten.

A lot of people (including me, wait, why am I reading mails ;) ) are 
currently out, and will likely be out for the remainder of the week.

I'd assume people will look into it next week.

-- 
Cheers

David
