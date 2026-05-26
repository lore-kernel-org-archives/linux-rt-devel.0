Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E872139C9
	for <linux-rt-devel@lists.linux.dev>; Tue, 26 May 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784121; cv=none; b=p5qs7Bdn/G+qPQVF6P4izpG5y/b8zuYWQo0sBS+InzlDAQb/CDbLFnHFgaBteCJ+SIIy2pVG39MqztjCQzu+Ygi9A11V9QA/m5FcqFEvVpU3AmJk4tjvxQnfHKsILuWX2Tlr4IC+CHgY0dE3NG2oxz5zElqO5j04eHtcJFwDHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784121; c=relaxed/simple;
	bh=OLZEus+tCL11fm5pjczjLroLeFvpHRb7wyyV18rDJdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1eywGokhyIJMzD0WSCmObiWbLIpOTAAeu/nKOlhXVEHEV7xcbvaiBmtkVVV97JpP7qM7CWRpnxkXF6IZ474EZ+1armBiGiqI8aknyokJAQ7W24ZzcMRVu/SOaB3ZbmvzSOvB3pndfDqatrUFwaqL1c/tXfwPPp06pzfpnGuwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YPvff5e1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A8xG6QD3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YPvff5e1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A8xG6QD3"
Date: Tue, 26 May 2026 10:28:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779784118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLZEus+tCL11fm5pjczjLroLeFvpHRb7wyyV18rDJdo=;
	b=YPvff5e1CqWDNw0LdhWd/NJTJdY0t3d+BO+fF9C7go3km0AU9OU0oKEgMSRpEDqSGQqkrm
	bQagXu8iCrP5ZdU4Ol53J9hhDddmjY0niil5EJOM3kmsZpMBieptHfpRyzGMw7Xz+z08Lz
	223fz+dRSYTKE7k9Qo7UNvkGMNP+qxz1ePFYd42kbXBdz8Ntw1aZ8xcBXnmbH923rvaMJ5
	H4DRMBgvRQ3rF4ii0r9LJk7VnTAtBptZAqFtfUXo54g9EwkBbfgk1BiOkwq2eYxi3sAAcp
	PZ56Rxfzs/vyMeOQMK8BJDyfhN9ANrhvryyU0z0IRPJcoicCQEk3qkdAb5y94w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779784118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLZEus+tCL11fm5pjczjLroLeFvpHRb7wyyV18rDJdo=;
	b=A8xG6QD3U0AlvPv5eFmggfqrUJ1hYC5luFTi2p5IDfdF0a88uKbba8DStU3iPZZPv21xDb
	uQMSgpIcCxrIGuBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Michal Hocko <mhocko@suse.com>
Cc: Waiman Long <longman@redhat.com>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] gfp_types: Introduce a new GFP_ATOMIC_RT gfp flag
Message-ID: <20260526082836.9BOv1yCM@linutronix.de>
References: <20260520204628.933654-1-longman@redhat.com>
 <ahQLVgj8zV4xQRh9@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ahQLVgj8zV4xQRh9@tiehlicka>

On 2026-05-25 10:41:58 [+0200], Michal Hocko wrote:
> Before we go this way we need to really be clear we do want to support
> raw_spinlock (aka RT) contexts. This is a big commitment because it
> dictates internal allocator locking that would have potentially a much

This is only needed for 2/2 of this series and Marc didn't want it.

Sebastian
