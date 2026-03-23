Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37099348452;
	Mon, 23 Mar 2026 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297568; cv=none; b=FAzaZTrzrM4LPNjbJQQclUw7y2Tb+UXO5y2kNfIMrm5sJX3ZF+yxQr94YZvSXo5CblYAzyrKHhfAaZ6twAgPLtoV7aNzchZg6204dgGP4IUh9czFEqqQxqthaiSb0H1AJkRtkYBt7oim6U0v1oXyL0zsXHID6JP+vDHAfvaTTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297568; c=relaxed/simple;
	bh=5Sp63JReJLZTZJuTwtijwpBpoSJpQfr3461ngWL4Ye4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzFakXjvkwhuwTDCig5Mg1luS0RvijB204hJ3td9R4bEImRxnWSxZcgz/RxrEnv0+IAJvzjyHwNYQU7eloCs8rgz0YH1srYcFnUw+iXXyc9yIJg5lJutP4UF8paSspiKM/BZSN/oVHw4LkK0Njak74SE3Q8YvjX6p9B1Ul6MI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBA0C4CEF7;
	Mon, 23 Mar 2026 20:26:07 +0000 (UTC)
Date: Mon, 23 Mar 2026 15:26:06 -0500
From: Clark Williams <clark.williams@gmail.com>
To: "Moritz KLAMMLER (FERCHAU)" <Moritz.Klammler@ferchau.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AW: Possible PREEMPT_RT live-lock / priority-inversion between
 FUTEX_CMP_REQUEUE_PI and FUTEX_WAIT_REQUEUE_PI
Message-ID: <acGh3pAAS5Ju6l0Y@demetrius>
References: <VE1PR06MB6894BE61C173D802365BE19DFF4CA@VE1PR06MB6894.eurprd06.prod.outlook.com>
 <20260323133034.vk87xPj9@linutronix.de>
 <PR3PR06MB68891F0E8CF17A4260D46EE8FF4BA@PR3PR06MB6889.eurprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3PR06MB68891F0E8CF17A4260D46EE8FF4BA@PR3PR06MB6889.eurprd06.prod.outlook.com>

On Mon, Mar 23, 2026 at 04:12:24PM +0000, Moritz KLAMMLER (FERCHAU) wrote:
> 
> >> we're running Linux 6.6 with PREEMPT_RT on a single-core armv7l machine
> > v6.6.109+?
> 
> Yes, 6.6.122 to be precise.
> 

Moritz,

Just to satisfy my curiosity, are you running my stable v6.6-rt kernels
or rolling your own? (Not that it would affect this bug at all, since my
tree has the same issue). 

Thanks,
Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
